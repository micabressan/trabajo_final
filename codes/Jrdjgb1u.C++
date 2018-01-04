#include <glew.h>
#include <SDL.h>
#include <fstream>
#include <sstream>
#include <iostream>
#include <glm.hpp>
#include <vector>
#include <gtc/matrix_transform.hpp>

static const GLfloat g_color_buffer_data[] = 
{
	0.583f,  0.771f,  0.014f,  1,
	0.609f,  0.115f,  0.436f, 1,
	0.327f,  0.483f,  0.844f, 1,
	0.822f,  0.569f,  0.201f, 1,
	0.435f,  0.602f,  0.223f, 1,
	0.310f,  0.747f,  0.185f, 1,
	0.597f,  0.770f,  0.761f, 1,
	0.559f,  0.436f,  0.730f, 1,
	0.359f,  0.583f,  0.152f, 1,
	0.483f,  0.596f,  0.789f, 1,
	0.559f,  0.861f,  0.639f, 1,
	0.195f,  0.548f,  0.859f, 1,
	0.014f,  0.184f,  0.576f, 1,
	0.771f,  0.328f,  0.970f, 1,
	0.406f,  0.615f,  0.116f, 1,
	0.676f,  0.977f,  0.133f, 1,
	0.971f,  0.572f,  0.833f, 1,
	0.140f,  0.616f,  0.489f, 1,
	0.997f,  0.513f,  0.064f, 1,
	0.945f,  0.719f,  0.592f, 1,
	0.543f,  0.021f,  0.978f, 1,
	0.279f,  0.317f,  0.505f, 1,
	0.167f,  0.620f,  0.077f, 1,
	0.347f,  0.857f,  0.137f, 1,
	0.055f,  0.953f,  0.042f, 1,
	0.714f,  0.505f,  0.345f, 1,
	0.783f,  0.290f,  0.734f, 1,
	0.722f,  0.645f,  0.174f, 1,
	0.302f,  0.455f,  0.848f, 1,
	0.225f,  0.587f,  0.040f, 1,
	0.517f,  0.713f,  0.338f, 1,
	0.053f,  0.959f,  0.120f, 1,
	0.393f,  0.621f,  0.362f, 1,
	0.673f,  0.211f,  0.457f, 1,
	0.820f,  0.883f,  0.371f, 1,
	0.982f,  0.099f,  0.879f, 1
};

static const GLfloat g_vertex_buffer_data[] =
{
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

GLuint CreateShaderProgram(const GLchar * vertexShaderText, const GLchar* fragmentShaderText);
std::string loadFromFile(std::string fileName);

void VBO();

GLuint vbo;
GLuint vao;

GLuint colorBuffer;

int main(int arg, char*args[])
{
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3);
	SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
	SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE, 8);

	SDL_Init(SDL_INIT_EVERYTHING);

	SDL_Window* mainWindow = SDL_CreateWindow("openGLwindow", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 800, 600, SDL_WINDOW_OPENGL);
	SDL_GLContext context = SDL_GL_CreateContext(mainWindow);

	SDL_GL_SetSwapInterval(1);

	glewExperimental = true;

	glewInit();

	std::string vertexShader = loadFromFile("shader.vert.glsl");
	std::string fragmentShader = loadFromFile("shader.frag.glsl");

	GLuint shaderProgram = CreateShaderProgram(vertexShader.c_str(), fragmentShader.c_str());

	glUseProgram(shaderProgram);

	VBO();

	glm::mat4 Projection = glm::perspective(glm::radians(45.0f), 4.0f / 3.0f, 0.1f, 100.0f); // 2.0, 6.0

	glm::mat4 View = glm::lookAt(glm::vec3(4, 3, 3), glm::vec3(-1, -1, 0), glm::vec3(0,1,0));
	glm::mat4 Model = glm::mat4(1.0f);

	glm::mat4 mvp = Projection * View * Model;

	GLuint matrixID = glGetUniformLocation(shaderProgram, "MVP");

	SDL_Event *event = new SDL_Event;
	bool quit = false;

	while (!quit && event->type != SDL_QUIT)
	{
		SDL_PollEvent(event);

		glClearDepthf(1.0);

		glClearColor(0.0, 0.0, 0.0, 1.0);
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		glUniformMatrix4fv(matrixID, 1, GL_FALSE, &mvp[0][0]);

		glDrawArrays(GL_TRIANGLES, 0, 12 * 3);

		SDL_GL_SwapWindow(mainWindow);
	}

	glDisableVertexAttribArray(0);
	glDisableVertexAttribArray(1);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glDeleteBuffers(1, &vbo);
	glDeleteBuffers(1, &vao);
	glDeleteBuffers(1, &colorBuffer);

	return 0;
}

GLuint CreateShaderProgram(const GLchar * vertexShaderText, const GLchar* fragmentShaderText)
{
	GLuint vertexShader = glCreateShader(GL_VERTEX_SHADER);
	GLuint fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);

	GLuint shaderProgram = glCreateProgram();

	glShaderSource(vertexShader, 1, &vertexShaderText, NULL);
	glCompileShader(vertexShader);

	GLint isCompiled = 0;
	glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &isCompiled);
	if (isCompiled == GL_FALSE)
	{
		GLint maxLength = 0;
		glGetShaderiv(vertexShader, GL_INFO_LOG_LENGTH, &maxLength);

		std::vector<GLchar> infoLog(maxLength);
		glGetShaderInfoLog(vertexShader, maxLength, &maxLength, &infoLog[0]);

		glDeleteShader(vertexShader);

		std::cout << '%s\n' << &infoLog[0] << std::endl;

		return 0;
	}

	glShaderSource(fragmentShader, 1, &fragmentShaderText, NULL);
	glCompileShader(fragmentShader);

	glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &isCompiled);
	if (isCompiled == GL_FALSE)
	{
		GLint maxLength = 0;
		glGetShaderiv(fragmentShader, GL_INFO_LOG_LENGTH, &maxLength);

		std::vector<GLchar> infoLog(maxLength);
		glGetShaderInfoLog(fragmentShader, maxLength, &maxLength, &infoLog[0]);

		glDeleteShader(fragmentShader);
		glDeleteShader(vertexShader);

		std::cout << '%s\n' << &infoLog[0] << std::endl;

		return 0;
	}

	glAttachShader(shaderProgram, vertexShader);
	glAttachShader(shaderProgram, fragmentShader);

	glLinkProgram(shaderProgram);

	GLint isLinked = 0;
	glGetProgramiv(shaderProgram, GL_LINK_STATUS, (int *)&isLinked);
	if (isLinked == GL_FALSE)
	{
		GLint maxLength = 0;
		glGetProgramiv(shaderProgram, GL_INFO_LOG_LENGTH, &maxLength);

		std::vector<GLchar> infoLog(maxLength);
		glGetProgramInfoLog(shaderProgram, maxLength, &maxLength, &infoLog[0]);

		glDeleteProgram(shaderProgram);
		glDeleteShader(vertexShader);
		glDeleteShader(fragmentShader);

		std::cout << '%s\n' << &infoLog[0] << std::endl;

		return 0;
	}

	glDetachShader(shaderProgram, vertexShader);
	glDetachShader(shaderProgram, fragmentShader);

	glDeleteShader(vertexShader);
	glDeleteShader(fragmentShader);

	return shaderProgram;
}

std::string loadFromFile(std::string fileName)
{
	std::ifstream openFile(fileName);
	std::stringstream sstream;

	if (!openFile.is_open())
	{
		std::cout << "Could not find the file: " << fileName << std::endl;
	}

	sstream << openFile.rdbuf();

	return sstream.str();
}

void VBO()
{
	glGenBuffers(1, &vbo);
	glBindBuffer(GL_ARRAY_BUFFER, vbo);
	glBufferData(GL_ARRAY_BUFFER, sizeof(g_vertex_buffer_data), g_vertex_buffer_data, GL_STATIC_DRAW);

	glGenBuffers(1, &colorBuffer);
	glBindBuffer(GL_ARRAY_BUFFER, colorBuffer);
	glBufferData(GL_ARRAY_BUFFER, sizeof(g_color_buffer_data), g_color_buffer_data, GL_STATIC_DRAW);

	glBindBuffer(GL_ARRAY_BUFFER, vbo);
	glBindBuffer(GL_ARRAY_BUFFER, colorBuffer);

	glGenVertexArrays(1, &vao);
	glBindVertexArray(vao);

	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, (void*)0);
	glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, (void*)0);

	glEnableVertexAttribArray(0);
	glEnableVertexAttribArray(1);
}




//----------------- SHADERS --------------------
//===============-  VERTEX -=====================
#version 330 core

layout (location = 0) in vec3 pos;
layout (location = 1) in vec4 col;

out vec4 vertexColor;

uniform mat4 MVP;

void main()
{
	gl_Position = MVP * vec4(pos.xyz, 1.0);
	vertexColor = col;
}

//==============- FRAGMENT -===================
#version 330 core

out vec4 outColor;

in vec4 vertexColor;

void main()
{
	outColor = vertexColor;
}