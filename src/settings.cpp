#include "settings.h"

Settings::Settings(QObject *parent, const QString &organization, const QString &application) :
    QObject(parent), settings_(new QSettings(organization, application)), demoMode_(false) {
}

Settings::~Settings() {
    delete settings_;
}

bool Settings::contains(const QString & key) const {
    if (demoMode_) return false;
    return settings_->contains(key);
}

void Settings::setValue(const QString &key, const QVariant &value) {
    if (demoMode_) return;
    settings_->setValue(key, value);
}

QVariant Settings::value(const QString &key, const QVariant &defaultValue) const {
    if (demoMode_) return defaultValue;
    return settings_->value(key, defaultValue);
}

void Settings::setVersion(QString version) {
    appVersion = version;
}

QString Settings::getVersion() {
    return appVersion;
}

void Settings::setDemoMode(bool demo) {
    demoMode_ = demo;
}
