#include "myclass.h"


MyClass::MyClass():
    manager(nullptr),mIsLoading(false)
{
    manager = new QNetworkAccessManager(this);
    connect(manager,SIGNAL(finished(QNetworkReply*)),this,SLOT(dataIsReady(QNetworkReply*)));
}

MyClass::~MyClass()
{
    mutex.lock();
    mutex.unlock();
}


bool MyClass::isLoading() const
{
    return mIsLoading;
}

void MyClass::setIsLoading(bool isLoading)
{
    mIsLoading = isLoading;
    emit onIsLoadingChanged(mIsLoading);
}

void MyClass::get(QUrl _url)
{
    mutex.lock();
    setIsLoading(true);

    manager->get(QNetworkRequest(_url));
}

void MyClass::dataIsReady(QNetworkReply *reply)
{
    if(reply)
    {
        emit dataRecived(reply->readAll());
    }
    setIsLoading(false);
    mutex.unlock();
}
