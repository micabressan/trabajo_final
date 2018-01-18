package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"runtime"
	"strings"

	"github.com/go-gl/gl/v4.1-core/gl"
	"github.com/go-gl/glfw/v3.1/glfw"
	"github.com/go-gl/mathgl/mgl32"
)

const vertexShaderSource = `
#version 330
layout(location = 0) in vec4 pv;
void main(void)
{
	gl_Position = pv;
}
`

const fragmentShaderSource = `
#version 330
out vec4 fc;
void main(void)
{
	fc = vec4(1.0, 0.0, 0.0, 1.0);
}
`

type VertexTN struct {
	p, n mgl32.Vec3
	c    mgl32.Vec4
	t    mgl32.Vec2
}

func (v VertexTN) Size() int {
	return (4*3)*2 + 4*4 + 4*2
}

type InstanceData struct {
	modelMatrix   mgl32.Mat4
	colorModifier mgl32.Vec4
}

func (id InstanceData) Size() int {
	return (4*4)*4 + 4*4
}

type VAO struct {
	vao                      uint32
	elementArrayBufferObject uint32
	vertexBufferObject       uint32
	numIndices               int
}

type RendererData struct {
	passthruShader     uint32
	quadVAO            VAO
	instanceDataBuffer uint32
}

func createVertexBuffer(vertexBuffer *uint32, vertexs []VertexTN, numVertexs int) {
	gl.GenBuffers(1, vertexBuffer)
	gl.BindBuffer(gl.ARRAY_BUFFER, *vertexBuffer)
	gl.BufferData(gl.ARRAY_BUFFER, VertexTN{}.Size()*numVertexs, gl.Ptr(vertexs), gl.STATIC_DRAW)
}

func createIndexBuffer(indexBuffer *uint32, idxs []uint16, numIdxs int) {
	gl.GenBuffers(1, indexBuffer)
	gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, *indexBuffer)
	gl.BufferData(gl.ELEMENT_ARRAY_BUFFER, 2*numIdxs, gl.Ptr(idxs), gl.STATIC_DRAW)
}

func createVertexArrayObject(vertexs []VertexTN, numVertexs int, indices []uint16, numIndices int) VAO {
	vao := VAO{
		numIndices: numIndices,
	}

	createIndexBuffer(&vao.elementArrayBufferObject, indices, numIndices)
	createVertexBuffer(&vao.vertexBufferObject, vertexs, numVertexs)

	gl.GenVertexArrays(1, &vao.vao)
	gl.BindVertexArray(vao.vao)

	gl.BindBuffer(gl.ARRAY_BUFFER, vao.vertexBufferObject)

	gl.EnableVertexAttribArray(0)
	gl.VertexAttribPointer(0, 3, gl.FLOAT, false, 0, nil) // Revise

	gl.EnableVertexAttribArray(1)
	gl.VertexAttribPointer(1, 4, gl.FLOAT, false, 0, nil) // Revise

	gl.EnableVertexAttribArray(2)
	gl.VertexAttribPointer(2, 2, gl.FLOAT, false, 0, nil) // Revise

	gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, vao.elementArrayBufferObject)

	gl.BindVertexArray(0)
	gl.BindBuffer(gl.ARRAY_BUFFER, 0)
	gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, 0)

	return vao
}

func createUniformBuffer() uint32 {
	var instanceDataBuffer uint32

	gl.GenBuffers(1, &instanceDataBuffer)
	gl.BindBuffer(gl.UNIFORM_BUFFER, instanceDataBuffer)
	gl.BufferData(gl.UNIFORM_BUFFER, InstanceData{}.Size(), gl.Ptr(nil), gl.DYNAMIC_DRAW)
	gl.BindBuffer(gl.UNIFORM_BUFFER, 0)

	return instanceDataBuffer
}

func updateUniformBuffer(instanceDataBuffer *uint32, position mgl32.Vec2) {
	instanceData := InstanceData{mgl32.Mat4{}, mgl32.Vec4{1, 0, 0, 1}}
	//instanceData := InstanceData{mgl32.Translate(mgl32.Mat4{}, position.Vec3(0)), mgl32.Vec4{1, 1, 1, 1}}

	gl.BindBuffer(gl.UNIFORM_BUFFER, *instanceDataBuffer)
	gl.BufferSubData(gl.UNIFORM_BUFFER, 0, InstanceData{}.Size(), gl.Ptr(instanceData))
	gl.BindBufferBase(gl.UNIFORM_BUFFER, 0, *instanceDataBuffer)
}

func init() {
	runtime.LockOSThread()
}

func main() {
	if err := glfw.Init(); err != nil {
		panic(fmt.Errorf("could not initialize glfw: %v", err))
	}
	defer glfw.Terminate()

	glfw.WindowHint(glfw.ContextVersionMajor, 4)
	glfw.WindowHint(glfw.ContextVersionMinor, 1)
	glfw.WindowHint(glfw.Resizable, glfw.False)
	glfw.WindowHint(glfw.OpenGLProfile, glfw.OpenGLCoreProfile)
	glfw.WindowHint(glfw.OpenGLForwardCompatible, glfw.True)

	monitor := glfw.GetPrimaryMonitor()

	window, err := glfw.CreateWindow(1920, 1080, "Shaders", monitor, nil)
	if err != nil {
		panic(err)
	}

	window.MakeContextCurrent()

	if err := gl.Init(); err != nil {
		panic(err)
	}

	rendererData := RendererData{}
	// Compile shaders
	fs, err := compileShader(fragmentShaderSource, gl.FRAGMENT_SHADER)
	if err != nil {
		panic(err)
	}
	vs, err := compileShader(vertexShaderSource, gl.VERTEX_SHADER)
	if err != nil {
		panic(err)
	}

	// Link shaders
	if !linkShaders(vs, fs) {
		panic("could not link shaders")
	}

	// deleteShaders?
	if vs > 0 {
		gl.DeleteShader(vs)
	}
	if fs > 0 {
		gl.DeleteShader(fs)
	}

	gl.UseProgram(rendererData.passthruShader)

	idxs := []uint16{
		0, 1, 2,
		2, 1, 3,
	}
	vtxs := []VertexTN{ //Omplim la pantalla amb un quad. (pos, normal, color, textura)
		{mgl32.Vec3{-1, -1, 0}, mgl32.Vec3{0, 0, 1}, mgl32.Vec4{1, 1, 1, 1}, mgl32.Vec2{0, 0}},
		{mgl32.Vec3{+1, -1, 0}, mgl32.Vec3{0, 0, 1}, mgl32.Vec4{1, 1, 1, 1}, mgl32.Vec2{1, 0}},
		{mgl32.Vec3{-1, +1, 0}, mgl32.Vec3{0, 0, 1}, mgl32.Vec4{1, 1, 1, 1}, mgl32.Vec2{0, 1}},
		{mgl32.Vec3{+1, +1, 0}, mgl32.Vec3{0, 0, 1}, mgl32.Vec4{1, 1, 1, 1}, mgl32.Vec2{1, 1}},
	}

	rendererData.instanceDataBuffer = createUniformBuffer()
	rendererData.quadVAO = createVertexArrayObject(vtxs, 4, idxs, 6)

	//gl.ClearColor(0, 0.5, 1.0, 1.0)

	for !window.ShouldClose() {
		// Do OpenGL stuff.
		gl.ClearColor(0, 0, 0, 0)
		gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

		gl.UseProgram(rendererData.passthruShader)

		window.SwapBuffers()
		glfw.PollEvents()
	}
}

// Read shader code from file
func readShaderCode(filePath string) string {
	code := ""
	f, err := os.Open(filePath)
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		code += "\n" + scanner.Text()
	}
	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
	code += "\x00"
	return code
}

// Compile shader. Source is null terminated c string. shader type is self
// explanatory
func compileShader(source string, shaderType uint32) (uint32, error) {

	// Create new shader
	shader := gl.CreateShader(shaderType)
	// Convert shader string to null terminated c string
	shaderCode, free := gl.Strs(source)
	defer free()
	gl.ShaderSource(shader, 1, shaderCode, nil)

	// Compile shader
	gl.CompileShader(shader)

	// Check shader status
	var status int32
	gl.GetShaderiv(shader, gl.COMPILE_STATUS, &status)
	if status == gl.FALSE {
		var logLength int32
		gl.GetShaderiv(shader, gl.INFO_LOG_LENGTH, &logLength)

		log := strings.Repeat("\x00", int(logLength+1))
		gl.GetShaderInfoLog(shader, logLength, nil, gl.Str(log))

		return 0, fmt.Errorf("failed to compile %v: %v", source, log)
	}
	return shader, nil
}

func linkShaders(vs, fs uint32) bool {
	programID := gl.CreateProgram()
	gl.AttachShader(programID, vs)
	gl.AttachShader(programID, fs)
	gl.LinkProgram(programID)
	var success int32
	gl.GetProgramiv(programID, gl.LINK_STATUS, &success)
	return success != 0
}