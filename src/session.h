#ifndef SESSION_H
#define SESSION_H

#include <QObject>
#include <QString>
#include <QVariantList>
#include <QDateTime>

class Session : public QObject
{
    Q_OBJECT
    Q_PROPERTY(quint32 score READ score CONSTANT)
    Q_PROPERTY(quint32 bestScore READ bestScore CONSTANT)
    Q_PROPERTY(QVariantList cells READ cells CONSTANT)

public:
    explicit Session(QObject *parent = nullptr);

    Q_INVOKABLE bool load();
    Q_INVOKABLE void save(quint32 score, quint32 bestScore, const QVariantList &cells, bool isDead);

    quint32 score() const { return m_score; }
    quint32 bestScore() const { return m_bestScore; }
    QVariantList cells() const { return m_cells; }

private:
    QString m_filePath;
    quint32 m_score = 0;
    quint32 m_bestScore = 0;
    QVariantList m_cells;
};

#endif // SESSION_H
