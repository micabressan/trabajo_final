#include "widgetopengldraw.h"
#include <iostream>
#include <glm/glm.hpp>
#include <glm/ext.hpp>
#include <memory>
#include <QOpenGLFunctions_3_3_Core>
#include <QApplication>
#include <QMouseEvent>


float MiskaX=0;
float MiskaY=0;
float Tipka1X=0;
float Tipka1Y=0;
float Tipka1Z=-5;

int preklaplaplanje=1;
float skaliranje1X=1;
float skaliranje1Y=1;
float skaliranje1Z=1;

float translacija1X=0;
float translacija1Y=0;
float translacija1Z=0;

WidgetOpenGLDraw::WidgetOpenGLDraw(QWidget *parent)
		: QOpenGLWidget(parent) {
}

void WidgetOpenGLDraw::mouseMoveEvent(QMouseEvent *event)
{
    MiskaX=event->pos().x();
    MiskaY=event->pos().y();
    update();
}
void WidgetOpenGLDraw::keyPressEvent(QKeyEvent *event)
{
    if(event->key()==Qt::Key_2)//premik kamere v desno
        Tipka1X++;
    if(event->key()==Qt::Key_1)//premik kamere v levo
        Tipka1X--;
    if(event->key()==Qt::Key_3)//premik kamere gor
        Tipka1Y++;
    if(event->key()==Qt::Key_4)//premik kamere dol
        Tipka1Y--;
    if(event->key()==Qt::Key_5)//premik kamere k tebi
        Tipka1Z++;
    if(event->key()==Qt::Key_6)//premik kamere od tebe
        Tipka1Z--;
    if(event->key()==Qt::Key_Up)//perspektivna
        preklaplaplanje=1;
    if(event->key()==Qt::Key_Down)//orto
        preklaplaplanje=2;
    if(event->key()==Qt::Key_I)//skaliranjeX +
        skaliranje1X+=0.5;
    if(event->key()==Qt::Key_K)//skaliranjeX -
        skaliranje1X-=0.5;
    if(event->key()==Qt::Key_J)//skaliranjeY +
        skaliranje1Y+=0.5;
    if(event->key()==Qt::Key_L)//skaliranjeY -
        skaliranje1Y-=0.5;
    if(event->key()==Qt::Key_O)//skaliranjeZ +
        skaliranje1Z+=0.5;
    if(event->key()==Qt::Key_P)//skaliranjeZ -
        skaliranje1Z-=0.5;
    if(event->key()==Qt::Key_D)//translacijaX +
        translacija1X+=0.5;
    if(event->key()==Qt::Key_A)//translacijaX -
        translacija1X-=0.5;
    if(event->key()==Qt::Key_W)//translacijaY +
        translacija1Y+=0.5;
    if(event->key()==Qt::Key_S)//translacijaY -
        translacija1Y-=0.5;
    if(event->key()==Qt::Key_E)//translacijaZ +
        translacija1Z+=0.5;
    if(event->key()==Qt::Key_R)//translacijaZ -
        translacija1Z-=0.5;
    update();
}

WidgetOpenGLDraw::~WidgetOpenGLDraw() {

}
void WidgetOpenGLDraw::printProgramInfoLog(GLuint obj) {
	int infologLength = 0;
	gl.glGetProgramiv(obj, GL_INFO_LOG_LENGTH, &infologLength);
	if (infologLength > 0) {
		std::unique_ptr<char[]> infoLog(new char[infologLength]);
		int charsWritten = 0;
		gl.glGetProgramInfoLog(obj, infologLength, &charsWritten, infoLog.get());
		std::cerr << infoLog.get() << "\n";
	}
}

void WidgetOpenGLDraw::printShaderInfoLog(GLuint obj) {
	int infologLength = 0;
	gl.glGetShaderiv(obj, GL_INFO_LOG_LENGTH, &infologLength);
	if (infologLength > 0) {
		std::unique_ptr<char[]> infoLog(new char[infologLength]);
		int charsWritten = 0;
		gl.glGetShaderInfoLog(obj, infologLength, &charsWritten, infoLog.get());
		std::cerr << infoLog.get() << "\n";
	}
}

void WidgetOpenGLDraw::PrevediSencilnike() {
	id_sencilni_program = gl.glCreateProgram();

	{  // vhod v senčilnik oglišč je in_Pos, izhod pa gl_Position (rezervirana
		// beseda)
		GLuint vs = gl.glCreateShader(GL_VERTEX_SHADER);
        std::string vss;
		vss += " #version 330	                       \n";
		vss += " layout(location=0) in vec3 in_Pos;	 \n";
		vss += " uniform mat4 PVM;						       \n";
		vss += " void main(){						             \n";
        vss += "  gl_Position=PVM*vec4(in_Pos.xyz,1);\n";
        //vss+="  gl_Position=vec4(in_Pos.xy,1,1);  \n";
		vss += " }                                   \n ";
        //std::cout << vss;
		const char *vssc = vss.c_str();
		gl.glShaderSource(vs, 1, &vssc, nullptr);
		gl.glCompileShader(vs);
		printShaderInfoLog(vs);
		gl.glAttachShader(id_sencilni_program, vs);
	}

	{  // out_Color je barva, ki bo prišla do zaslona
		GLuint fs = gl.glCreateShader(GL_FRAGMENT_SHADER);
        std::string fss;
		fss += " #version 330					        \n";
		fss += " out vec4 out_Color;	        \n";
		fss += " void main(){					        \n";
		fss += "  out_Color=vec4(0.5,1,0,1);  \n";
		fss += " }						                \n";
        //std::cout << fss;
		const char *fssc = fss.c_str();
		gl.glShaderSource(fs, 1, &fssc, nullptr);
		gl.glCompileShader(fs);
		printShaderInfoLog(fs);
		gl.glAttachShader(id_sencilni_program, fs);
	}

	gl.glLinkProgram(id_sencilni_program);
	printProgramInfoLog(id_sencilni_program);
	id_sencilni_program_PVM_uniform =
			gl.glGetUniformLocation(id_sencilni_program, "PVM");
    //TLA
    id_sencilni_program2 = gl.glCreateProgram();

    {  // vhod v senčilnik oglišč je in_Pos, izhod pa gl_Position (rezervirana
        // beseda)
        GLuint vs = gl.glCreateShader(GL_VERTEX_SHADER);
        std::string vss;
        vss += " #version 330	                       \n";
        vss += " layout(location=0) in vec3 in_Pos;	 \n";
        vss += " uniform mat4 PVM;						       \n";
        vss += " void main(){						             \n";
        vss += "  gl_Position=PVM*vec4(in_Pos.xyz,1);\n";
        //vss+="  gl_Position=vec4(in_Pos.xy,1,1);  \n";
        vss += " }                                   \n ";
        //std::cout << vss;
        const char *vssc = vss.c_str();
        gl.glShaderSource(vs, 1, &vssc, nullptr);
        gl.glCompileShader(vs);
        printShaderInfoLog(vs);
        gl.glAttachShader(id_sencilni_program2, vs);
    }

    {  // out_Color je barva, ki bo prišla do zaslona
        GLuint fs = gl.glCreateShader(GL_FRAGMENT_SHADER);
        std::string fss;
        fss += " #version 330					        \n";
        fss += " out vec4 out_Color;	        \n";
        fss += " void main(){					        \n";
        fss += "  out_Color=vec4(0,1,1,1);  \n";
        fss += " }						                \n";
        //std::cout << fss;
        const char *fssc = fss.c_str();
        gl.glShaderSource(fs, 1, &fssc, nullptr);
        gl.glCompileShader(fs);
        printShaderInfoLog(fs);
        gl.glAttachShader(id_sencilni_program2, fs);
    }

    gl.glLinkProgram(id_sencilni_program2);
    printProgramInfoLog(id_sencilni_program2);
    id_sencilni_program_PVM_uniform2 =
            gl.glGetUniformLocation(id_sencilni_program2, "PVM");
}

void WidgetOpenGLDraw::initializeGL() {
	// naložimo funkcije za OpenGL


	if(!gl.initializeOpenGLFunctions()){
		std::cerr <<"Required openGL not supported"<<std::endl;
		QApplication::exit(1);
	}


	PrevediSencilnike();

     glEnable(GL_DEPTH_TEST);		//v primeru, da rišemo več prekrivajočih
	// trikotnikov, želimo, da sprednje ne prekrijejo tisti, ki bi morali biti
	// odzadaj
     glDisable(GL_CULL_FACE);		//rišemo obe lici trikotnikov

	// dejansko nosi lastnosti povezane z buffer (npr. stanje od
	// glEnableVertexAttribArray itd)
	// uporabno predvsem za večjo hitrost
	gl.glGenVertexArrays(1, &id_VAO_trikotnik);
	gl.glBindVertexArray(id_VAO_trikotnik);

	// naložimo trikotnik na GPU in določimo podatke
    static const GLfloat trikotnik[] = {
        -1.0f,-1.0f,-1.0f, // triangle 1 : begin
        -1.0f,-1.0f, 1.0f,
        -1.0f, 1.0f, 1.0f, // triangle 1 : end
        1.0f, 1.0f,-1.0f, // triangle 2 : begin
        -1.0f,-1.0f,-1.0f,
        -1.0f, 1.0f,-1.0f, // triangle 2 : end
        1.0f,-1.0f, 1.0f,
        -1.0f,-1.0f,-1.0f,
        1.0f,-1.0f,-1.0f,
        1.0f, 1.0f,-1.0f,
        1.0f,-1.0f,-1.0f,
        -1.0f,-1.0f,-1.0f,
        -1.0f,-1.0f,-1.0f,
        -1.0f, 1.0f, 1.0f,
        -1.0f, 1.0f,-1.0f,
        1.0f,-1.0f, 1.0f,
        -1.0f,-1.0f, 1.0f,
        -1.0f,-1.0f,-1.0f,
        -1.0f, 1.0f, 1.0f,
        -1.0f,-1.0f, 1.0f,
        1.0f,-1.0f, 1.0f,
        1.0f, 1.0f, 1.0f,
        1.0f,-1.0f,-1.0f,
        1.0f, 1.0f,-1.0f,
        1.0f,-1.0f,-1.0f,
        1.0f, 1.0f, 1.0f,
        1.0f,-1.0f, 1.0f,
        1.0f, 1.0f, 1.0f,
        1.0f, 1.0f,-1.0f,
        -1.0f, 1.0f,-1.0f,
        1.0f, 1.0f, 1.0f,
        -1.0f, 1.0f,-1.0f,
        -1.0f, 1.0f, 1.0f,
        1.0f, 1.0f, 1.0f,
        -1.0f, 1.0f, 1.0f,
        1.0f,-1.0f, 1.0f
    };
    static const GLfloat tla[] =
        {
             2.0f,  -1.0f, 2.0f,
            -2.0f,  -1.0f, -2.0f,
        };
	gl.glGenBuffers(1, &id_buffer_trikotnik);
	gl.glBindBuffer(GL_ARRAY_BUFFER, id_buffer_trikotnik);
    gl.glBufferData(GL_ARRAY_BUFFER, sizeof(glm::vec3) * 12*3, trikotnik, GL_STATIC_DRAW);
	gl.glEnableVertexAttribArray(0);  // uporabjamo: layout(location=0) in vec3 in_Pos;
    gl.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(glm::vec3), 0);

    //TLA
    gl.glGenVertexArrays(1, &id_VAO_tla);
    gl.glBindVertexArray(id_VAO_tla);

    gl.glGenBuffers(1, &id_buffer_tla);
    gl.glBindBuffer(GL_ARRAY_BUFFER, id_buffer_tla);
    gl.glBufferData(GL_ARRAY_BUFFER, sizeof(glm::vec3) * 2*3, tla, GL_STATIC_DRAW);
    gl.glEnableVertexAttribArray(0);  // uporabjamo: layout(location=0) in vec3 in_Pos;
    gl.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(glm::vec3), 0);
}

void WidgetOpenGLDraw::resizeGL(int w, int h) { gl.glViewport(0, 0, w, h); }

void WidgetOpenGLDraw::paintGL() {
	// počisti ozadje in globinski pomnilnik (za testiranje globine)
    gl.glClearColor(0.2, 0.2, 0.2, 1);
	gl.glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    gl.glBindVertexArray(id_VAO_trikotnik);
	gl.glUseProgram(id_sencilni_program);

	{
        glm::mat4 P;
        if(preklaplaplanje==1)
            P = glm::perspective(20.0f, (float)width() / height(), 0.01f, 1000.0f);// projekcijska matrika
        if(preklaplaplanje==2)
            P= glm::ortho(20.0f, (float)width()/(float)height(), 0.01f, 1000.0f);//vzporedna (ortogonalna)


        glm::mat4 V = glm::mat4(1);  // matrika pogleda (view) (premikanje kamere...)
        V = glm::translate(V, glm::vec3(Tipka1X, Tipka1Y, Tipka1Z));//premikanje kamere po (sceni) vseh treh dimenzijah

        glm::mat4 M = glm::mat4(1);  // model matrix: premikanje objektov
        M = glm::rotate_slow(M, glm::radians(MiskaX), glm::vec3(0, 1, 0));//x os
        M = glm::rotate_slow(M, glm::radians(MiskaY), glm::vec3(1, 0, 0));//y os

        M = glm::scale(M,glm::vec3(skaliranje1X,skaliranje1Y,skaliranje1Z));//skaliranje - neenakomerno
        M = glm::translate(M,glm::vec3(translacija1X,translacija1Y,translacija1Z));//translacija -enakomerna

		glm::mat4 PVM = P * V * M;

		gl.glUniformMatrix4fv(id_sencilni_program_PVM_uniform, 1, GL_FALSE, glm::value_ptr(PVM));
	}
    gl.glDrawArrays(GL_TRIANGLES, 0, 12*3);  // 3 točke

    //TLA
    gl.glBindVertexArray(id_VAO_tla);
    gl.glUseProgram(id_sencilni_program2);

    {
        glm::mat4 P;
        if(preklaplaplanje==1)
            P = glm::perspective(20.0f, (float)width() / height(), 0.01f, 1000.0f);// projekcijska matrika
        if(preklaplaplanje==2)
            P= glm::ortho(20.0f, (float)width()/(float)height(), 0.01f, 1000.0f);//vzporedna (ortogonalna)


        glm::mat4 V = glm::mat4(1);  // matrika pogleda (view) (premikanje kamere...)
        V = glm::translate(V, glm::vec3(Tipka1X, Tipka1Y, Tipka1Z));//premikanje kamere po (sceni) vseh treh dimenzijah

        glm::mat4 M = glm::mat4(1);  // model matrix: premikanje objektov
        //M = glm::rotate_slow(M, glm::radians(MiskaX), glm::vec3(0, 1, 0));//x os
        //M = glm::rotate_slow(M, glm::radians(MiskaY), glm::vec3(1, 0, 0));//y os

        //M = glm::scale(M,glm::vec3(skaliranje1X,skaliranje1Y,skaliranje1Z));//skaliranje - neenakomerno
        //M = glm::translate(M,glm::vec3(translacija1X,translacija1Y,translacija1Z));//translacija -enakomerna

        glm::mat4 PVM = P * V * M;

        gl.glUniformMatrix4fv(id_sencilni_program_PVM_uniform2, 1, GL_FALSE, glm::value_ptr(PVM));
    }
    gl.glDrawArrays(GL_TRIANGLES, 0, 2*3);  // 3 točke

	const int err = gl.glGetError();
	if (err != 0) {
		std::cerr << "OpenGL napaka: " << err << std::endl;
	}
}