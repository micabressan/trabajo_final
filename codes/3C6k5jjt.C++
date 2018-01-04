#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "qmath.h"
#include "QTime"
struct diagnandver
{
 float Pj [8];
 int ogr; //количество симптомов в диагнозе
 float Pnj [8];
 int ns [8]; //Номер симптома в списке симптомов
 bool symptom_was[8];
 bool symptom_in; //флаг о том, что симптом входит в диагноз
};
int yes;
int no;
int ii;
int clever_question = 1;
int theend = 0;
float Pminmax;
 int first = 0;
 int count_tr =0;
int symadd;
int indexcursym;
float probability_min=0.01;
const int index_s = 38;
const int indexes = 10;
QString symptoms [index_s];
QString diagnozis [indexes];

float ver_sympt [index_s];
int ver_sympt_ind [index_s];

QList<float> ListofPa;
QList<float> ListofPmax;
QList<float> ListofPmin;
QList<int> Numb_sympt;          //Список с номерами симптомов
QList<int> N_smpt_was;          //Список симптомов, которые уже были
QList<int> Sympt_yes_or_no;     //2-вопроса не было. 1-ответ да. 0 - ответ нет
QList<int> Numb_diag_false;     //Список с неправильными диагнозами
QList<int> Numb_diagnoz;        //Номер диагнозов
QList<QString> Listofsympt;     //Список симптомов
QList<QString> L_of_dgnz;       //Список диагнозов
QList<int> L_ofsmpt_inf;        //Список информативности
diagnandver pd [indexes];       //Объявление структуры
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QTime midnight(0,0,0);
    qsrand(midnight.secsTo(QTime::currentTime()));
    pd[0].ogr = 6;
    pd[0].ns[0]=0;      pd[0].ns[1]=1;      pd[0].ns[2]=2;
    pd[0].ns[3]=3;      pd[0].ns[4]=4;      pd[0].ns[5]=7;
    pd[0].Pnj[0] = 0.3; pd[0].Pnj[1] = 0.3; pd[0].Pnj[2] = 0.3;
    pd[0].Pnj[3] = 0.1; pd[0].Pnj[4] = 0.1; pd[0].Pnj[5] = 0.4;
    pd[0].Pj[0] = 0.8;  pd[0].Pj[1] = 0.85; pd[0].Pj[2] = 0.2;
    pd[0].Pj[3] = 0.8;  pd[0].Pj[4] = 0.9;  pd[0].Pj[5] = 0.5;

    pd[1].ogr = 7;
    pd[1].ns[0]=0;      pd[1].ns[1]=1;      pd[1].ns[2]=2;
    pd[1].ns[3]=5;      pd[1].ns[4]=6;      pd[1].ns[5]=7;      pd[1].ns[6]=8;
    pd[1].Pnj[0] = 0.2; pd[1].Pnj[1] = 0.3; pd[1].Pnj[2] = 0.4; pd[1].Pnj[3] = 0.1;
    pd[1].Pnj[4] = 0.5; pd[1].Pnj[5] = 0.4; pd[1].Pnj[6] = 0.3;
    pd[1].Pj[0] = 0.7;  pd[1].Pj[1] = 0.8;  pd[1].Pj[2] = 0.1;  pd[1].Pj[3] = 0.6;
    pd[1].Pj[4] = 0.4;  pd[1].Pj[5] = 0.7;  pd[1].Pj[6] = 0.6;

    pd[2].ogr = 6;
    pd[2].ns[0]=9;      pd[2].ns[1]=10;      pd[2].ns[2]=11;
    pd[2].ns[3]=12;     pd[2].ns[4]=15;      pd[2].ns[5]=2;
    pd[2].Pnj[0] = 0.3; pd[2].Pnj[1] = 0.05; pd[2].Pnj[2] = 0.2;
    pd[2].Pnj[3] = 0.1; pd[2].Pnj[4] = 0.1;  pd[2].Pnj[5] = 0.4;
    pd[2].Pj[0] = 0.8;  pd[2].Pj[1] = 0.9;   pd[2].Pj[2] = 0.5;
    pd[2].Pj[3] = 0.2;  pd[2].Pj[4] = 0.3;   pd[2].Pj[5] = 0.1;

    pd[3].ogr = 5;
    pd[3].ns[0]=13;      pd[3].ns[1]=14;      pd[3].ns[2]=15;
    pd[3].ns[3]=12;      pd[3].ns[4]=16;
    pd[3].Pnj[0] = 0.05; pd[3].Pnj[1] = 0.05; pd[3].Pnj[2] = 0.2;
    pd[3].Pnj[3] = 0.2;  pd[3].Pnj[4] = 0.02;
    pd[3].Pj[0] = 0.8;   pd[3].Pj[1] = 0.9;   pd[3].Pj[2] = 0.6;
    pd[3].Pj[3] = 0.1;   pd[3].Pj[4] = 0.3;


    pd[4].ogr = 7;
    pd[4].ns[0]=12;      pd[4].ns[1]=17;      pd[4].ns[2]=18;     pd[4].ns[3]=19;
    pd[4].ns[4]=16;      pd[4].ns[5]=20;      pd[4].ns[6]=7;
    pd[4].Pnj[0] = 0.1;  pd[4].Pnj[1] = 0.02; pd[4].Pnj[2] = 0.3; pd[4].Pnj[3] = 0.5;
    pd[4].Pnj[4] = 0.1;  pd[4].Pnj[5] = 0.1;  pd[4].Pnj[6] = 0.3;
    pd[4].Pj[0] = 0.4;   pd[4].Pj[1] = 0.9;   pd[4].Pj[2] = 0.5;  pd[4].Pj[3] = 0.3;
    pd[4].Pj[4] = 0.4;   pd[4].Pj[5] = 0.8;   pd[4].Pj[6] = 0.4;

    pd[5].ogr = 6;
    pd[5].ns[0]=21;      pd[5].ns[1]=22;      pd[5].ns[2]=18;
    pd[5].ns[3]=19;      pd[5].ns[4]=7;       pd[5].ns[5]=2;
    pd[5].Pnj[0] = 0.03; pd[5].Pnj[1] = 0.005;pd[5].Pnj[2] = 0.5;
    pd[5].Pnj[3] = 0.5;  pd[5].Pnj[4] = 0.4;  pd[5].Pnj[5] = 0.1;
    pd[5].Pj[0] = 0.6;   pd[5].Pj[1] = 0.8;   pd[5].Pj[2] = 0.3;
    pd[5].Pj[3] = 0.7;   pd[5].Pj[4] = 0.7;   pd[5].Pj[5] = 0.3;

    pd[6].ogr = 6;
    pd[6].ns[0]=23;      pd[6].ns[1]=24;      pd[6].ns[2]=25;
    pd[6].ns[3]=26;      pd[6].ns[4]=12;      pd[6].ns[5]=16;
    pd[6].Pnj[0] = 0.3;  pd[6].Pnj[1] = 0.01; pd[6].Pnj[2] = 0.1;
    pd[6].Pnj[3] = 0.1;  pd[6].Pnj[4] = 0.2;  pd[6].Pnj[5] = 0.1;
    pd[6].Pj[0] = 0.8;   pd[6].Pj[1] = 0.7;   pd[6].Pj[2] = 0.5;
    pd[6].Pj[3] = 0.6;   pd[6].Pj[4] = 0.1;   pd[6].Pj[5] = 0.2;

    pd[7].ogr = 8;
    pd[7].ns[0]=27;      pd[7].ns[1]=28;      pd[7].ns[2]=29;
    pd[7].ns[3]=30;      pd[7].ns[4]=16;      pd[7].ns[5]=3;
    pd[7].ns[6]=0;       pd[7].ns[7]=37;
    pd[7].Pnj[0] = 0.3;  pd[7].Pnj[1] = 0.01; pd[7].Pnj[2] = 0.4;
    pd[7].Pnj[3] = 0.1;  pd[7].Pnj[4] = 0.1;  pd[7].Pnj[5] = 0.4;
    pd[7].Pnj[6] = 0.5;  pd[7].Pnj[7] = 0.1;
    pd[7].Pj[0] = 0.8;   pd[7].Pj[1] = 0.9;   pd[7].Pj[2] = 0.5;
    pd[7].Pj[3] = 0.3;   pd[7].Pj[4] = 0.3;   pd[7].Pj[5] = 0.7;
    pd[7].Pj[6] = 0.1;   pd[7].Pj[7] = 0.3;

    pd[8].ogr = 6;
    pd[8].ns[0]=31;      pd[8].ns[1]=32;      pd[8].ns[2]=33;
    pd[8].ns[3]=34;      pd[8].ns[4]=18;      pd[8].ns[5]=19;
    pd[8].Pnj[0] = 0.5;  pd[8].Pnj[1] = 0.05; pd[8].Pnj[2] = 0.05;
    pd[8].Pnj[3] = 0.6;  pd[8].Pnj[4] = 0.4;  pd[8].Pnj[5] = 0.7;
    pd[8].Pj[0] = 0.4;   pd[8].Pj[1] = 0.9;   pd[8].Pj[2] = 0.8;
    pd[8].Pj[3] = 0.3;   pd[8].Pj[4] = 0.5;   pd[8].Pj[5] = 0.4;

    pd[9].ogr = 5;
    pd[9].ns[0]=35;      pd[9].ns[1]=36;      pd[9].ns[2]=8;
    pd[9].ns[3]=6;       pd[9].ns[4]=1;
    pd[9].Pnj[0] = 0.1;  pd[9].Pnj[1] = 0.1;  pd[9].Pnj[2] = 0.3;
    pd[9].Pnj[3] = 0.6;  pd[9].Pnj[4] = 0.5;
    pd[9].Pj[0] = 0.8;   pd[9].Pj[1] = 0.5;   pd[9].Pj[2] = 0.7;
    pd[9].Pj[3] = 0.5;   pd[9].Pj[4] = 0.4;

    symptoms[0]  = "Процессорный модуль циклически переинициализируется? (1)";
    symptoms[1]  = "Не стартует коммутационная плата? (2)";
    symptoms[2]  = "Присутствует световой сигнал ошибки коммутационной платы? (3)";
    symptoms[3]  = "Сильный нагрев процессорного модуля? (4)";
    symptoms[4]  = "Сильный нагрев деталей модуля питания питания процессора? (5)";
    symptoms[5]  = "Не работают порты ввода вывода модуля интерфейсного? (6)";
    symptoms[6]  = "Приборный отсек не реагирует на разовый сброс модуля питания? (7)";
    symptoms[7]  = "Не загружается программное обеспечение процессорного модуля? (8)";
    symptoms[8]  = "Выключение системы во время работы? (9)";
    symptoms[9]  = "Не выводится изображение дорожек дальности на дисплее стенда проверки РЛС БО? (10)";
    symptoms[10] = "Искажения выводимого изображения на дисплее стенда? (11)";
    symptoms[11] = "При переустановке ПО появляется «Критическая ошибка ядра», процессорного модуля? (12)";
    symptoms[12] = "Физическое повреждение корпуса? (13)";
    symptoms[13] = "Внутренняя система контроля(ВСК) модуля интерфейсного сообщает об отказе портов ввода/вывода? (14)";
    symptoms[14] = "Не поступает пакет состояния (ВСК) модулей аппаратного отсека в входной буфер   модуля интерфейсного? (15)";
    symptoms[15] = "Состояние ВСК сообщает, что устройство работает неправильно? (16)";
    symptoms[16] = "Повреждены разъемы питания? (17)";
    symptoms[17] = "Постоянные щелчки или скрежет блока A5 АРБМ.435336.002-02? (18)";
    symptoms[18] = "Медленный доступ к файлам поправочных коэффициентов луча АФАР? (19)";
    symptoms[19] = "Отказ системы и появление в консоли «Критической ошибки ядра»? (20)";
    symptoms[20] = "Отсутствие или повреждение данных? (21)";
    symptoms[21] = "Сильный нагрев микросхем ОЗУ? (22)";
    symptoms[22] = "Сбой или зависание программ обработки радиолокационного сигнала, требующий большое количество ОЗУ? (23)";
    symptoms[23] = "Последовательных канал RS-485 не отображается в диспетчере устройств стенда проверки аппаратных модулей? (24)";
    symptoms[24] = "На дифференциальных линиях передачи данных RS-485 отсутствуют требуемые напряжения –7 В до +12 В? (25)";
    symptoms[25] = "Интерфейс определяется в системе, но информация не принимается/передается? (26)";
    symptoms[26] = "Сбои при передаче пакета данных по линиям RS-485, в полнодуплексном режиме? (27)";
    symptoms[27] = "Не работает помпа насоса СЖО? (28)";
    symptoms[28] = "Загрязнены трубки передачи охлаждающей жидкости СЖО? (29)";
    symptoms[29] = "При выполнение боевых задач модули аппаратного блока выключается? (30)";
    symptoms[30] = "Повреждены кабели питания? (31)";
    symptoms[31] = "В режиме радиомолчания наблюдается высокая загруженность процессорного модуля? (32)";
    symptoms[32] = "Изменение режимов работы РЛС без участия оператора? (33)";
    symptoms[33] = "В консоль выводятся непредвиденные сообщения, изображения? (34)";
    symptoms[34] = "Замедление работы операционной системы реального времени? (35)";
    symptoms[35] = "Полное отсутствие любой индикации приборного отсека (отсутствие питания)? (36)";
    symptoms[36] = "Не работает текстовый LCD-дисплей блока питания? (37)";
    symptoms[37] = "Сильные шумы от трансформаторов блока питания? (38)";

    diagnozis[0] = "Неисправен процессорный модуль ТИАЖ.487125.5";
    diagnozis[1] = "Неисправна коммутационная плата ТИАЖ.468125.2";
    diagnozis[2] = "Вышел из строя DSP-процессор";
    diagnozis[3] = "Неисправен модуль интерфейсный ТИАЖ.468532.3";
    diagnozis[4] = "Вышла из строя QDR память";
    diagnozis[5] = "Сбой ОЗУ";
    diagnozis[6] = "Неисправен канал передачи данных RS-485";
    diagnozis[7] = "Проблема с системой жидкостного охлаждения";
    diagnozis[8] = "Модуль имеет некорректную версию ПО";
    diagnozis[9] = "Неисправен модуль питания А-3645.01";
    Init();
    connect(ui->pushButton, SIGNAL(clicked()),
                this, SLOT(Yes())); //связываем кнопки с функциями
    connect(ui->pushButton_2, SIGNAL(clicked()),
                this, SLOT(No())); //связываем кнопки с функциями
    connect(ui->pushButton_3, SIGNAL(clicked()),
                this, SLOT(Init())); //связываем кнопки с функциями
}

MainWindow::~MainWindow()
{
    delete ui;
}
//Основная подпрограмма
void MainWindow:: expert()
{
    QString str;
    QList<int> nums;
    QList<int> numd;
    nums.clear();
    numd.clear();
    theend = 0;
    ui->textEdit_2->moveCursor(QTextCursor::End);
                        ui->textEdit_2->setText("");
    if(yes)
    {
        for(int j=0; j<L_of_dgnz.size();j++)
        {
            for(int k=0;k<pd[j].ogr;k++)
            {
            if(pd[j].ns[k] == indexcursym)
                   pd[j].symptom_in=1;
            }

        }
        ui->textEdit_3->insertPlainText(" Да");
        for(int j=0; j<L_of_dgnz.size();j++)
        {
            for(int k=0;k<pd[j].ogr;k++)
            {
            if(pd[j].ns[k] == indexcursym)
            {
                if(!pd[j].symptom_was[k])
                {
                ListofPa[j]=(ListofPa.at(j)*pd[j].Pj[k])/((ListofPa.at(j)*pd[j].Pj[k])+((1-ListofPa.at(j))*pd[j].Pnj[k]));
                                      //  ui->textEdit_3->append(QString::number(ListofPa.at(Numb_diagnoz.at(j))));
                }
                numd.append(j);
                nums.append(k);
                N_smpt_was[pd[j].ns[k]]=1;
                pd[j].symptom_was[k]=1;
                Sympt_yes_or_no[pd[j].ns[k]]=1;
                break;
            }
        }
        }
        ui->textEdit->setText("");
        for(int i=0;i<Listofsympt.size();i++)
        {
            if(!N_smpt_was.at(i))
            ui->textEdit->append(QString::number(L_ofsmpt_inf.at(i))+". "+Listofsympt.at(i));
        }
             maxandmin();
             for(int j=0; j<L_of_dgnz.size();j++)
             {
                 for(int k=0;k<pd[j].ogr;k++)
                 {
                 if((ListofPa.at(j)<probability_min))
                 {
                     if(L_ofsmpt_inf[pd[j].ns[k]]==1)
                     {
                     N_smpt_was[pd[j].ns[k]]=1;
                     pd[j].symptom_was[k]=1;
                     }
                     Numb_diag_false[j]=1;
                 }
                 }
                 if(!Numb_diag_false[j])
               ui->textEdit_2->append("P(Wj)=" + QString::number(ListofPa.at(j),'f',countofzero) + " " + "Pmax=" + QString::number(ListofPmax.at(j),'f',countofzero) + " " + " Pmin=" + QString::number(ListofPmin.at(j),'f',countofzero) + " " +L_of_dgnz.at(j));
         }
    }
    else if(no)
    {
        for(int j=0; j<L_of_dgnz.size();j++)
        {
            for(int k=0;k<pd[j].ogr;k++)
            {
            if(pd[j].ns[k] == indexcursym)
                pd[j].symptom_in=1;
            }
        }
              ui->textEdit_3->insertPlainText(" Нет");
              for(int j=0; j<L_of_dgnz.size();j++)
              {
                  for(int k=0;k<pd[j].ogr;k++)
                  {
                  if(pd[j].ns[k] == indexcursym)
                  {
                      if(!pd[j].symptom_was[k])
                      {
                      ListofPa[j]=(ListofPa.at(j)*(1-pd[j].Pj[k]))/((ListofPa.at(j)*(1-pd[j].Pj[k]))+((1-ListofPa.at(j))*(1-pd[j].Pnj[k])));
                                            //  ui->textEdit_3->append(QString::number(ListofPa.at(j)));
                        numd.append(j);
                        nums.append(k);
                          N_smpt_was[pd[j].ns[k]]=1;
                        pd[j].symptom_was[k]=1;
                                                Sympt_yes_or_no[pd[j].ns[k]]=0;
                      }
                      break;
                  }
              }
              }
              ui->textEdit->setText("");
              for(int i=0;i<Listofsympt.size();i++)
              {
                  if(!N_smpt_was.at(i))
                  ui->textEdit->append(QString::number(L_ofsmpt_inf.at(i))+". "+Listofsympt.at(i));
              }
             maxandmin();
             for(int j=0; j<L_of_dgnz.size();j++)
             {
                 for(int k=0;k<pd[j].ogr;k++)
                 {
                 if((ListofPa.at(j)<probability_min))
                 {
                     if(L_ofsmpt_inf[pd[j].ns[k]]==1)
                     {
                     N_smpt_was[pd[j].ns[k]]=1;
                     pd[j].symptom_was[k]=1;
                     }
                     Numb_diag_false[j]=1;
                 }
                 }
                 if(!Numb_diag_false[j])
               ui->textEdit_2->append("P(Wj)=" + QString::number(ListofPa.at(j),'f',countofzero) + " " + "Pmax=" + QString::number(ListofPmax.at(j),'f',countofzero) + " " + " Pmin=" + QString::number(ListofPmin.at(j),'f',countofzero) + " " +L_of_dgnz.at(j));
         }
    }
    if (theend)
        return;
    yes=0;
    no=0;
    symadd++;
    int vot_tak_vot = 0;
    for(int g=0;g<index_s;g++)
    {
        if(N_smpt_was[g])
            vot_tak_vot ++;

    }
    for(int j=0; j<L_of_dgnz.size();j++)
    if(!Numb_diag_false.at(j))
    if((ListofPa.at(j)>0.98))
    {
       ui->textEdit_3->append("Наиболее вероятный диагноз - " + L_of_dgnz.at(j));
       aboutproblem(j);
       ui->pushButton->setEnabled(0);
       ui->pushButton_2->setEnabled(0);
       theend = 1;
       return;
     }
    if((symadd==index_s)||(vot_tak_vot==index_s))
    {
           ui->textEdit->setText("Симптомы закончились");
           ui->pushButton->setEnabled(0);
           ui->pushButton_2->setEnabled(0);
    }
    else
    {
    nextquestion();
    }
}
void MainWindow:: Yes()
{
    yes=1;
    expert();
}
void MainWindow:: No()
{
    no=1;
    expert();
}
//Начальные условия
void MainWindow:: Init()
{
    first = 1;
     ui->label_4->setText("");
    ui->pushButton->setEnabled(1);
    ui->pushButton_2->setEnabled(1);
    ui->textEdit_2->setText("");
    ui->textEdit->setText("");
    ui->textEdit_3->setText("");
    N_smpt_was.clear();
    Numb_diag_false.clear();
    symadd=0;
    count_tr =0;
    L_ofsmpt_inf.clear();
    Listofsympt.clear();
    L_of_dgnz.clear();
    ListofPa.clear();
    ListofPmax.clear();
    ListofPmin.clear();
    Numb_sympt.clear();
    Numb_diagnoz.clear();
    Sympt_yes_or_no.clear();
    indexcursym= 0;
    for(int i = 0;i<indexes;i++)
        for(int j=0;j<pd[i].ogr;j++)
        {
            pd[i].symptom_was[j]=0;
            pd[i].symptom_in=0;
        }
    for(int i=0;i<index_s;i++)
    {
        L_ofsmpt_inf.append(inform[i]);
        Listofsympt.append(symptoms[i]);
        Numb_sympt.append(i);
        N_smpt_was.append(0);
        Sympt_yes_or_no.append(2);
    }
    for(int i=0;i<indexes;i++)
    {
        L_of_dgnz.append(diagnozis[i]);
        ListofPa.append(pa[i]);
        Numb_diagnoz.append(i);
        pmax[i]=0;
        pmin[i]=0;
        pWjnoX[i]=1;
        pWjX[i]=1;
        pnoWjnoX[i]=1;
        pnoWjX[i]=1;
        Numb_diag_false.append(0);
        ListofPmax.append(0);
        ListofPmin.append(0);
    }
    QString str;
    for(int i=0;i<Listofsympt.size();i++)
    {
        ui->textEdit->append(QString::number(L_ofsmpt_inf.at(i))+". "+Listofsympt.at(i));
    }
    str = "";
    maxandmin();
    for(int i=0;i<L_of_dgnz.size();i++)
    {
        ui->textEdit_2->append("P(Wj)=" + QString::number(ListofPa.at(i),'f',countofzero) + " " + "Pmax=" + QString::number(ListofPmax.at(i),'f',countofzero) + " " + " Pmin=" + QString::number(ListofPmin.at(i),'f',countofzero) + " " +L_of_dgnz.at(i));
    }
    QList<int> index;
    for(int i=0;i<Listofsympt.size();i++)
    {
        if((L_ofsmpt_inf.at(i)==4)||(L_ofsmpt_inf.at(i)==3))
        {index.append(i);
        }
    }
    int j = qrand() % index.size();
    indexcursym = index.at(j);
    ui->textEdit_3->append(Listofsympt.at(index.at(j)));
    first =0;
}
//расчет Pmax и Pmin
void MainWindow:: maxandmin()
{
    for(int i=0;i<indexes;i++)
    {
        pWjnoX[i]=1;
        pWjX[i]=1;
        pnoWjnoX[i]=1;
        pnoWjX[i]=1;
    }
    for(int j=0; j<L_of_dgnz.size();j++)
    {
        for(int k=0;k<pd[j].ogr;k++)
    {
            {
            if((!pd[j].symptom_was[k])||first)
            {
                if((pd[j].Pj[k]>=pd[j].Pnj[k]))
                {
                    pWjX[Numb_diagnoz.at(j)] = pWjX[Numb_diagnoz.at(j)] *pd[j].Pj[k];
                    pnoWjX[Numb_diagnoz.at(j)] = pnoWjX[Numb_diagnoz.at(j)]*pd[j].Pnj[k];
                    pWjnoX[Numb_diagnoz.at(j)] = pWjnoX[Numb_diagnoz.at(j)]*(1-pd[j].Pj[k]);
                    pnoWjnoX[Numb_diagnoz.at(j)] = pnoWjnoX[Numb_diagnoz.at(j)]*(1-pd[j].Pnj[k]);

                }
                else
                {
                    pWjX[Numb_diagnoz.at(j)] = pWjX[Numb_diagnoz.at(j)]*(1-pd[j].Pj[k]);
                    pnoWjX[Numb_diagnoz.at(j)] = pnoWjX[Numb_diagnoz.at(j)]*(1-pd[j].Pnj[k]);
                    pWjnoX[Numb_diagnoz.at(j)] = pWjnoX[Numb_diagnoz.at(j)]*(1-(1-pd[j].Pj[k]));
                    pnoWjnoX[Numb_diagnoz.at(j)] = pnoWjnoX[Numb_diagnoz.at(j)]*(1-(1-pd[j].Pnj[k]));
                }

            }
            }
        }
    }
    for(int j=0; j<indexes;j++)
    {
                ListofPmin[j]=(ListofPa[j]*pWjnoX[j])/((ListofPa[j]*pWjnoX[j])+((1-ListofPa[j])*pnoWjnoX[j]));
                ListofPmax[j]=(ListofPa[j]*pWjX[j])/((ListofPa[j]*pWjX[j])+((1-ListofPa[j])*pnoWjX[j]));
                if(ListofPmax[j]<ListofPa[j])
                {
                    Numb_diag_false[j]=1;
                }
    }
    min();
     int counter = count_tr-1;
    for(int r=0;r<indexes;r++)
    {
        if(!Numb_diag_false.at(r))
        if((L_of_dgnz.at(ii)!=L_of_dgnz.at(r)))
        if((Pminmax>ListofPmax.at(r))&&r!=ii)
        {
            counter--;
        }
     if((counter==0)&&(!Numb_diag_false.at(ii)))
     {
        ui->textEdit_3->append("Наиболее вероятный диагноз - " + L_of_dgnz.at(ii));
        aboutproblem(ii);
        ui->pushButton->setEnabled(0);
        ui->pushButton_2->setEnabled(0);
        theend = 1;
        return;
      }
    }
}
//Выбор максимально минимальной вероятности
void MainWindow:: min()
 {
    for(int i=0;i<indexes;i++)
    {
        if(!Numb_diag_false.at(i))
        {
    Pminmax = ListofPmin[i];
    break;
        }
    }
     ii = 0;
     count_tr=0;
     for(int i=0;i<indexes;i++)
     {
         if(!Numb_diag_false.at(i))
         {
         if(Pminmax>ListofPmin[i])
         {
             Pminmax=Pminmax;
             ii = ii;

         }
         else
             {
                 Pminmax=ListofPmin[i];
                 ii = i;
             }
         count_tr++;
         }
     }
 }
 void MainWindow:: nextquestion()
 {
     QList<int> index;
     index.clear();
     bool max_inf4 =0;
     bool max_inf3 =0;
     bool max_inf2 =0;
     bool max_inf1 =0;
     //умный подбор вопроса
    //Не подбирает вопросы, которые логично не сходятся.  Система включается? - да, Нет питания ПК ?
     if(clever_question)
     {
         ui->textEdit_2->setText("");
         ui->textEdit->setText("");
     for(int i=0;i<Listofsympt.size();i++)
     {
         if(Sympt_yes_or_no[i]==1)
         {
         if((i==0)||(i==1)||(i==6)||(i==7)||(i==9)||(i==35))
         {
             N_smpt_was[pd[1].ns[6]]=1;
             pd[1].symptom_was[6]=1;
             N_smpt_was[pd[2].ns[2]]=1;
             pd[2].symptom_was[2]=1;
             N_smpt_was[pd[2].ns[4]]=1;
             pd[2].symptom_was[4]=1;
             N_smpt_was[pd[3].ns[0]]=1;
             pd[3].symptom_was[0]=1;
             N_smpt_was[pd[3].ns[1]]=1;
             pd[3].symptom_was[1]=1;
             N_smpt_was[pd[3].ns[2]]=1;
             pd[3].symptom_was[2]=1;
             N_smpt_was[pd[4].ns[2]]=1;
             pd[4].symptom_was[2]=1;
             N_smpt_was[pd[4].ns[3]]=1;
             pd[4].symptom_was[3]=1;
             N_smpt_was[pd[4].ns[5]]=1;
             pd[4].symptom_was[5]=1;
             N_smpt_was[pd[5].ns[1]]=1;
             pd[5].symptom_was[1]=1;
             N_smpt_was[pd[5].ns[2]]=1;
             pd[5].symptom_was[2]=1;
             N_smpt_was[pd[5].ns[3]]=1;
             pd[5].symptom_was[3]=1;
             N_smpt_was[pd[6].ns[0]]=1;
             pd[6].symptom_was[0]=1;
             N_smpt_was[pd[6].ns[1]]=1;
             pd[6].symptom_was[1]=1;
             N_smpt_was[pd[6].ns[2]]=1;
             pd[6].symptom_was[2]=1;
             N_smpt_was[pd[6].ns[3]]=1;
             pd[6].symptom_was[3]=1;
             N_smpt_was[pd[7].ns[2]]=1;
             pd[7].symptom_was[2]=1;
             N_smpt_was[pd[8].ns[0]]=1;
             pd[8].symptom_was[0]=1;
             N_smpt_was[pd[8].ns[1]]=1;
             pd[8].symptom_was[1]=1;
             N_smpt_was[pd[8].ns[2]]=1;
             pd[8].symptom_was[2]=1;
             N_smpt_was[pd[8].ns[3]]=1;
             pd[8].symptom_was[3]=1;
             N_smpt_was[pd[8].ns[4]]=1;
             pd[8].symptom_was[4]=1;
             N_smpt_was[pd[8].ns[5]]=1;
             pd[8].symptom_was[5]=1;
             N_smpt_was[pd[9].ns[2]]=1;
             pd[8].symptom_was[2]=1;
             Numb_diag_false[8]=1;
             Numb_diag_false[3]=1;
             Numb_diag_false[6]=1;
            ui->label_4->setText("Диагнозы: Неисправен канал RS-485, Некорректную версию ПО, Неисправен модуль ТИАЖ.468532.3, так как нет доступа к МП ТИАЖ.487125.5");
         }
         if((i==2)||(i==0)||(i==5)||(i==8)||(i==10)||(i==11)||(i==13)||(i==14)||(i==15)||(i==18)||(i==19)||(i==20)||(i==22)||(i==23)||(i==24)||(i==25)||(i==29)||(i==31)||(i==32)||(i==33)||(i==34)||(i==37))
         {
             N_smpt_was[pd[0].ns[1]]=1;
             pd[0].symptom_was[1]=1;
             N_smpt_was[pd[1].ns[1]]=1;
             pd[1].symptom_was[1]=1;
             N_smpt_was[pd[9].ns[4]]=1;
             pd[9].symptom_was[4]=1;
             N_smpt_was[pd[1].ns[4]]=1;
             pd[1].symptom_was[4]=1;
             N_smpt_was[pd[9].ns[3]]=1;
             pd[9].symptom_was[3]=1;
             N_smpt_was[pd[9].ns[0]]=1;
             pd[9].symptom_was[0]=1;
            ui->label_4->setText("Питание есть");
         }

     }

         if(!N_smpt_was.at(i))
              ui->textEdit->append(QString::number(L_ofsmpt_inf.at(i))+". "+Listofsympt.at(i));
     }
     for(int j=0;j<indexes;j++)
     {
     if(!Numb_diag_false[j])
   ui->textEdit_2->append("P(Wj)=" + QString::number(ListofPa.at(j),'f',countofzero) + " " + "Pmax=" + QString::number(ListofPmax.at(j),'f',countofzero) + " " + " Pmin=" + QString::number(ListofPmin.at(j),'f',countofzero) + " " +L_of_dgnz.at(j));
}
     }
//Выбор симптома с максимальной информативностью
     for(int i=0;i<Listofsympt.size();i++)
     {
         if(!N_smpt_was.at(i))
         {
         if(L_ofsmpt_inf.at(i)==4)
         max_inf4 = 1;
         if(L_ofsmpt_inf.at(i)==3)
         max_inf3 = 1;
         if(L_ofsmpt_inf.at(i)==2)
         max_inf2 = 1;
         if(L_ofsmpt_inf.at(i)==1)
         max_inf1 = 1;
         }

     }
     if(max_inf4)
     {
     for(int i=0;i<Listofsympt.size();i++)
     {
         if(!N_smpt_was.at(i))
         {
         if(L_ofsmpt_inf.at(i)==4)
         {index.append(i);
         }
         }
     }
     goto metka;
     }
     if(max_inf3)
     {
     for(int i=0;i<Listofsympt.size();i++)
     {
         if(!N_smpt_was.at(i))
         {
         if(L_ofsmpt_inf.at(i)==3)
         {index.append(i);
         }
         }
     }
          goto metka;
     }
     if(max_inf2)
     {
     for(int i=0;i<Listofsympt.size();i++)
     {
         if(!N_smpt_was.at(i))
         {
         if(L_ofsmpt_inf.at(i)==2)
         {index.append(i);
         }
         }
     }
          goto metka;
     }
     if(max_inf1)
     {
     for(int i=0;i<Listofsympt.size();i++)
     {
         if(!N_smpt_was.at(i))
         {
         if(L_ofsmpt_inf.at(i)==1)
         {index.append(i);
         }
         }
     }
          goto metka;
     }
  metka:   int j = qrand() % index.size();
     indexcursym = index.at(j);
     ui->textEdit_3->append(Listofsympt.at(index.at(j)));
 }
 void MainWindow:: aboutproblem(int point)
 {
     switch (point) {
     case 0:  ui->label_4->setText("Неисправен процессорный модуль. За дополнительной информацией обратитесь в отдел 98 АО <Котлин-Новатор>");
         break;
     case 1:  ui->label_4->setText("Неисправно комполе. Необходимо провести диагностику согласно протоколу информационного взаимодействия ТИАЖ.123658.3 Д3");
         break;
     case 2:  ui->label_4->setText("Вышел из строя DSP-процессор. Обратитесь в отдел разработок ОКБ РЭС ГУАП");
         break;
     case 3:  ui->label_4->setText("Неисправен модуль интерфейсный ТИАЖ.468532.3. Необходио провести дополнительную проверку на стенде АБРМ.456325.3-01");
         break;
     case 4:  ui->label_4->setText("Вышла из строя QDR память. Необходима замена микросхемы DD2 CY7C15632KV18 модуля ТИАЖ.487125.5");
         break;
     case 5:  ui->label_4->setText("Повреждена ОЗУ. Необходима проверка платы ТИАЖ.487125.5-01 на рентгене в монтажном цехе АО <Котлин-Новатор>.");
         break;
     case 6:  ui->label_4->setText("Неисправен канал передачи данных RS-485. За дополнительной информацией обратитесь в отдел 54 АО <Котлин-Новатор>");
         break;
     case 7:  ui->label_4->setText("Заполните служебную записку по доработке СЖО и обратитесь к начальнику отдела 98 П.Ш.Непонятову ");
         break;
     case 8:  ui->label_4->setText("Модуль имеет некорректную версию ПО. Обратитесь в отдел 98 к начальнику лаборатории НИР-1 Сергиенко Э.С.");
         break;
     case 9:  ui->label_4->setText("Неисправен модуль питания А-3645.01. Неободима замена модуля.");
         break;
     }
 }