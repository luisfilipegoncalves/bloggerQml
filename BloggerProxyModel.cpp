#include "BloggerProxyModel.h"
#include <QDate>
#include <QDebug>

BloggerProxyModel::BloggerProxyModel(QObject *parent) :
    QSortFilterProxyModel(parent)
{
//    m_model = new BlogModel(this);
//    setSourceModel(m_model);

    connect(this, SIGNAL(dataChanged(QModelIndex,QModelIndex)), this, SLOT(dataChanged(QModelIndex,QModelIndex)));

//    QDate d, d2;
//    d = QDate::currentDate().addDays(-qrand()%720);
//    d2 = QDate::currentDate().addDays(qrand()%200);
//    addBlog("google", "www.google.com", qrand()%5+1, d, d2);

//    d = QDate::currentDate().addDays(-qrand()%720);
//    d2 = QDate::currentDate().addDays(qrand()%200);
//    addBlog("abola", "www.abola.com", qrand()%5+1, d, d2);

//    d = QDate::currentDate().addDays(-qrand()%720);
//    d2 = QDate::currentDate().addDays(qrand()%200);
//    addBlog("imaginando com linhas", "www.imaginandocomlinhas.com", qrand()%5+1, d, d2);

//    d = QDate::currentDate().addDays(-qrand()%720);
//    d2 = QDate::currentDate().addDays(qrand()%200);
//    addBlog("abertoatedemadrugada", "www.abertoatedemadrugada.com", qrand()%5+1, d, d2);

//    d = QDate::currentDate().addDays(-qrand()%720);
//    d2 = QDate::currentDate().addDays(qrand()%200);
//    addBlog("sapo tek", "www.sapo.tek.com", qrand()%5+1, d, d2);

//    d = QDate::currentDate().addDays(-qrand()%720);
//    d2 = QDate::currentDate().addDays(qrand()%200);
//    addBlog("pplware", "www.pplware.com", qrand()%5+1, d, d2);

//    d = QDate::currentDate().addDays(-qrand()%720);
//    d2 = QDate::currentDate().addDays(qrand()%200);
//    addBlog("macrumors", "www.macrumors.com", qrand()%5+1, d, d2);

//    d = QDate::currentDate().addDays(-qrand()%720);
//    d2 = QDate::currentDate().addDays(qrand()%200);
//    addBlog("aberto ate de madrugada", "http://abertoatedemadrugada.com/2013/10/como-fidelizar-os-clientes-recado-aos.html", qrand()%5+1, d, d2);

}

void BloggerProxyModel::search(const QString &text)
{
    setFilterWildcard(text);
}



void BloggerProxyModel::dataChanged(QModelIndex i1, QModelIndex i2)
{
    qDebug() << "Data changed... " << i1 << i2;
 }
