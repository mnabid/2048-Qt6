#include "session.h"
#include <QFile>
#include <QDataStream>
#include <QCryptographicHash>
#include <QDebug>
#include <QSettings>
#include <QFileInfo>
#include <QDir>

Session::Session(QObject *parent) : QObject(parent)
{
    QSettings settings("2048-qt", "2048-Qt");
    m_filePath = QFileInfo(settings.fileName()).absolutePath() + "/session.bin";
}

bool Session::load()
{
    if (m_filePath.isEmpty()) return false;

    QFile file(m_filePath);
    if (!file.open(QIODevice::ReadOnly)) return false;

    QDataStream in(&file);
    in.setByteOrder(QDataStream::LittleEndian);

    // Magic (4 bytes)
    char magic[4];
    if (in.readRawData(magic, 4) != 4 || memcmp(magic, "2048", 4) != 0) {
        return false;
    }

    // MD5 (16 bytes)
    QByteArray savedMd5 = file.read(16);
    if (savedMd5.size() != 16) return false;

    // Remaining data to verify MD5
    QByteArray data = file.readAll();
    QByteArray calculatedMd5 = QCryptographicHash::hash(data, QCryptographicHash::Md5);

    if (savedMd5 != calculatedMd5) {
        qWarning() << "Session file corrupted: MD5 mismatch";
        return false;
    }

    // Re-read data from the remaining part
    QDataStream dataIn(data);
    dataIn.setByteOrder(QDataStream::LittleEndian);

    qint64 timestamp;
    quint32 score, bestScore;
    quint8 gridSize;

    dataIn >> timestamp >> score >> bestScore >> gridSize;

    m_score = score;
    m_bestScore = bestScore;
    m_cells.clear();
    for (int i = 0; i < gridSize * gridSize; ++i) {
        quint8 val;
        dataIn >> val;
        m_cells.append(val);
    }

    return true;
}

void Session::save(quint32 score, quint32 bestScore, const QVariantList &cells, bool isDead)
{
    if (m_filePath.isEmpty()) return;

    // Ensure directory exists
    QDir().mkpath(QFileInfo(m_filePath).absolutePath());

    bool ClearGrid = isDead || !score;
    QByteArray data;
    {
        QDataStream out(&data, QIODevice::WriteOnly);
        out.setByteOrder(QDataStream::LittleEndian);

        qint64 timestamp = QDateTime::currentMSecsSinceEpoch();
        quint8 gridSize = 4; // Currently hardcoded to 4

        out << timestamp;
        out << (ClearGrid ? (quint32)0 : score);
        out << bestScore;
        out << gridSize;

        for (int i = 0; i < gridSize * gridSize; ++i) {
            if (ClearGrid || i >= cells.size()) {
                out << (quint8)0;
            } else {
                out << (quint8)cells[i].toUInt();
            }
        }
    }

    QByteArray md5 = QCryptographicHash::hash(data, QCryptographicHash::Md5);

    QFile file(m_filePath);
    if (file.open(QIODevice::WriteOnly)) {
        QDataStream out(&file);
        out.setByteOrder(QDataStream::LittleEndian);
        out.writeRawData("2048", 4);
        file.write(md5);
        file.write(data);
        file.close();
    }
}
