#ifndef MYCLASS_H
#define MYCLASS_H

#include <QtQml>
#include <QtCore>
#include <QtQuick>
#include <QtNetwork>

class MyClass : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isLoading READ isLoading WRITE setIsLoading NOTIFY onIsLoadingChanged)
public:
    MyClass();
    ~MyClass();

    bool isLoading() const;

signals:
    void onIsLoadingChanged(bool _value);
    void dataRecived(QString data);

private slots:
    void dataIsReady(QNetworkReply* reply);

public slots:
    void setIsLoading(bool isLoading);
    void get(QUrl _url);


private:
    QNetworkAccessManager*  manager;
    QMutex                  mutex;
    bool                    mIsLoading;
};



#endif // MYCLASS_H
