/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

/*This file is auto generate by dlib/dbus/proxyer. Don't edit it*/
#include <libintl.h>
#include <QtCore>
#include <qdebug.h>

#ifndef __LOCALE_H__
#define __LOCALE_H__

class DLocale: public QObject
{
    Q_OBJECT
public:
        //LC_ALL for all of the locale.

        //LC_COLLATE
        //for regular expression matching (it determines the meaning of range expressions and equivalence classes) and string collation.

        //LC_CTYPE
        //for regular expression matching, character classification, conversion, case-sensitive comparison, and wide character functions.

        //LC_MESSAGES
        //for localizable natural-language messages.

        //LC_MONETARY
        //for monetary formatting.

        //LC_NUMERIC
        //for number formatting (such as the decimal point and the thousands separator).

        //LC_TIME

    Q_PROPERTY(QString domain READ domain WRITE setDomain NOTIFY domainChanged)
    Q_PROPERTY(QUrl dirname READ dirname WRITE setDirname NOTIFY dirnameChanged)
    Q_PROPERTY(QString lang READ guestLang)

    Q_PROPERTY(QString localeALL READ localeALL WRITE setALL NOTIFY localeALLChanged)
    Q_PROPERTY(QString localeCOLLATE READ localeCOLLATE WRITE setCOLLATE NOTIFY localeCOLLATEChanged)
    Q_PROPERTY(QString localeCTYPE READ localeCTYPE WRITE setCTYPE NOTIFY localeCTYPEChanged)
    Q_PROPERTY(QString localeMESSAGES READ localeMESSAGES WRITE setMESSAGES NOTIFY localeMESSAGESChanged)
    Q_PROPERTY(QString localeMONETARY READ localeMONETARY WRITE setMONETARY NOTIFY localeMONETARYChanged)
    Q_PROPERTY(QString localeNUMERIC READ localeNUMERIC WRITE setNUMERIC NOTIFY localeNUMERICChanged)
    Q_PROPERTY(QString localeTIME READ localeTIME WRITE setTIME NOTIFY localeTIMEChanged)


    const QString domain() {
        return m_domain;
    }
    void setDomain (const QString& s) {
	if (!s.isEmpty()) {
	    m_domain = s;
	    updateBindTextdomain();
	} else {
	    qDebug () << "d-gettext: Ignore an empty domain name!";
	}
    }

    const QString dirname() {
    return m_dirname;
    }
    void updateBindTextdomain() {
	    if (m_dirname.length() == 0) {
		bindtextdomain(m_domain.toLocal8Bit(), "/usr/share/locale");
	    } else {
		bindtextdomain(m_domain.toLocal8Bit(), m_dirname.toLocal8Bit());
	    }
    }
    void setDirname (const QUrl& s) {
	if (s.isLocalFile()) {
	    m_dirname = s.path();
	    updateBindTextdomain();
	} else {
	    qDebug () << "d-gettext: Dirname is not supported non-local file";
	}
    }

    DLocale(QObject* parent=0)
        : QObject(parent)
    {
	 setlocale(LC_ALL, "");
    }


    Q_INVOKABLE const QString dsTr(const QString & msgId) {
        return dgettext(m_domain.toLocal8Bit(), msgId.toLocal8Bit());
    }

    const QString guestLang() {
        QString lang = qgetenv("LANGUAGE");
        if (lang.isEmpty()) {
                lang = localeMESSAGES();
                if (lang.isEmpty()) {
                lang = qgetenv("LANG");
            }
        }
        if (lang.isEmpty()) {
            return "en_US";
        }
        int index = lang.indexOf(".");
        if (index == -1) {
            return lang;
        }
        return lang.mid(0, index);
    }


    const QString localeALL() { return setlocale(LC_ALL, 0); }
    const QString localeCOLLATE() { return setlocale(LC_COLLATE, 0); }
    const QString localeCTYPE() { return setlocale(LC_CTYPE, 0); }
    const QString localeMESSAGES() { return setlocale(LC_MESSAGES, 0); }
    const QString localeMONETARY() { return setlocale(LC_MONETARY, 0); }
    const QString localeNUMERIC() { return setlocale(LC_NUMERIC, 0); }
    const QString localeTIME() { return setlocale(LC_TIME, 0); }

    void setALL(const QString& locale) {
        setlocale(LC_ALL, locale.toLocal8Bit());
    }
    void setCOLLATE(const QString& locale) {
        setlocale(LC_COLLATE, locale.toLocal8Bit());
    }
    void setCTYPE(const QString& locale) {
        setlocale(LC_CTYPE, locale.toLocal8Bit());
    }
    void setMESSAGES(const QString& locale) {
	setlocale(LC_MESSAGES, locale.toLocal8Bit());
    }
    void setMONETARY(const QString& locale) {
        setlocale(LC_MONETARY, locale.toLocal8Bit());
    }
    void setNUMERIC(const QString& locale) {
        setlocale(LC_NUMERIC, locale.toLocal8Bit());
    }
    void setTIME(const QString& locale) {
        setlocale(LC_TIME, locale.toLocal8Bit());
    }


Q_SIGNALS:
    void localeALLChanged(const QString&);
    void localeCOLLATEChanged(const QString&);
    void localeCTYPEChanged(const QString&);
    void localeMESSAGESChanged(const QString&);
    void localeMONETARYChanged(const QString&);
    void localeNUMERICChanged(const QString&);
    void localeTIMEChanged(const QString&);

    void domainChanged(const QString&);
    void dirnameChanged(const QUrl&);
private:
    QString m_domain;
    QString m_dirname;
};

#endif
