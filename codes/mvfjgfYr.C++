#add_file.h
#ifndef ADD_FILES_H
#define ADD_FILES_H
#include <QObject>
#include <QStringList>
#include <QSqlQuery>
#include <QSqlError>
#include <QFileInfo>
#include <QDir>
#include <QString>
#include <QVariant>
class add_files :public QObject{
    Q_OBJECT
public:
    add_files(QObject *parent=0);
    ~add_files();
    void set_files(QStringList nfiles);
    void set_dir(QString ndir);
private:
    QStringList files;
    QString dir;
private slots:
    void process_add_files();
    void process_parse_dir();
signals:
    void finished_add_files();
    void finished_parse_dir();
    void info_status(QString str);
};
#endif /*ADD_FILES_H*/

#add_file.cpp
#include "add_files.h"
add_files::add_files(QObject *parent)
    :QObject(parent){
}
add_files::~add_files(){
}
void add_files::process_add_files(){
    QSqlQuery query;
    QFileInfo fileinfo;
    QString str,str2;
    emit info_status("Записываю имена фалов в таблицу");
    query.exec("BEGIN");
    foreach(QString file,files){
	fileinfo.setFile(file);
	str2=fileinfo.fileName();
	str2=str2.right(str2.length()-str2.indexOf(QRegExp("\\.[A-zА-я\\d]{2,}$")));
	
	str="INSERT INTO mediafiles (filename,filepath,program,format,uses) VALUES ('"+fileinfo.fileName()+"','"+fileinfo.absolutePath()+"',(Select default_program.program FROM default_program,formats,format2extensions,extensions WHERE default_program.format=formats.id AND default_program.format=format2extensions.format AND format2extensions.extensions=extensions.id AND extensions.extensions='"+str2.toLower() +"'),(Select format2extensions.format From format2extensions,extensions Where format2extensions.extensions=extensions.id and extensions.extensions='"+str2.toLower()+"'),'0');";
	query.exec(str);
	emit info_status(query.lastError().text());
    }
    query.exec("COMMIT");
    emit finished_add_files();
 
	emit info_status("Запись завершил");
 
}
void add_files::process_parse_dir(){
    QStringList filters;
    QStringList dirs;
    QStringList curfiles;
    QStringList curdirs;
    QSqlQuery query;
    QDir path;
    QString buf;
    dirs.append(dir);
    emit info_status("Составляю список файлов");
    query.exec("SELECT extensions FROM extensions");
    while (query.next()){
	buf=query.value(0).toString();
	filters.append("*"+buf.toLower());
	filters.append("*"+buf.toUpper());
    }
    while (dirs.count()>0){
	curfiles.clear();
	curdirs.clear();
	path.setPath(dirs.first());
	path.setNameFilters(filters);
	path.setFilter(QDir::Files | QDir::NoDotAndDotDot | QDir::NoSymLinks);
	curfiles=path.entryList();
	foreach(QString str,curfiles){
	    files.append(dirs.first()+QDir::separator()+str);
	}
	path.setFilter(QDir::AllDirs | QDir::NoDotAndDotDot | QDir::NoSymLinks);
	curdirs=path.entryList();
	foreach(QString str,curdirs){
	    dirs.append(dirs.first()+QDir::separator()+str);
	}
	dirs.removeFirst();
    }
    emit finished_parse_dir();
    process_add_files();
}

void add_files::set_files(QStringList nfiles){
    files=nfiles;
}
void add_files::set_dir(QString ndir){
    dir=ndir;
}