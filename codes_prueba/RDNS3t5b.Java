package opengltest.nerv.com.opengltest;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.PointF;
import android.graphics.RectF;
import android.opengl.GLES20;
import android.opengl.GLSurfaceView;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.graphics.BitmapFactory;
import android.opengl.Matrix;
import android.util.Log;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.nio.ShortBuffer;

import static android.opengl.GLES20.GL_FLOAT;
import static android.opengl.GLES20.GL_FRAGMENT_SHADER;
import static android.opengl.GLES20.GL_TRIANGLES;
import static android.opengl.GLES20.GL_TRIANGLE_STRIP;
import static android.opengl.GLES20.GL_UNSIGNED_BYTE;
import static android.opengl.GLES20.GL_VERTEX_SHADER;
import static android.opengl.GLES20.glDrawArrays;
import static android.opengl.GLES20.glDrawElements;
import static android.opengl.GLES20.glUseProgram;

public class GLViewRenderer implements GLSurfaceView.Renderer {
    public static float texCoords[] = {
            0.0f, 0.0f,
            0.0f, 1.0f,
            1.0f, 1.0f,
            1.0f, 0.0f,
    };

    public static short inds[] = {
            1, 0, 3,
            1, 3, 2,

    };

    private int _programId;
    private int _programIdFBO;
    private Context _context;
    private int _textureId;

    private int fboId;
    private int fboTex;

    private int _imgW;
    private int _imgH;

    private int _glViewWidth;
    private int _glViewHeight;

    private int _aPositionLocation;
    private int _aTexCoordLocation;
    private int _uProjMLocation;
    private int _uModelMLocation;
    private int _uTextureLocation;
    private int _uColorLocation;
    private int _aPositionLocationfbo;

    public FloatBuffer _vertices;
    public FloatBuffer _texCoords;
    public ShortBuffer _indices;
    public FloatBuffer _verticesFbo;

    private float[] _screenProjM = new float[16];
    private float[] _modelM = new float[16];

    public GLViewRenderer(Context context) {
        _context = context;
    }

    @Override
    public void onSurfaceCreated(GL10 gl10, EGLConfig eglConfig) {
        // компилим шейдер
        int vertextShaderId = ShaderUtils.createShader(_context, GLES20.GL_VERTEX_SHADER, R.raw.vertex_shader);
        int fragmentShaderId = ShaderUtils.createShader(_context, GLES20.GL_FRAGMENT_SHADER, R.raw.fragment_shader);
        int fragmetShaderIdFBO = ShaderUtils.createShader(_context,GL_FRAGMENT_SHADER,R.raw.fragment_shader_fbo);
        int vertexShaderIdFBO = ShaderUtils.createShader(_context,GL_VERTEX_SHADER,R.raw.vetext_shader_fbo);

        _programId = ShaderUtils.createProgram(vertextShaderId, fragmentShaderId);
        _programIdFBO=ShaderUtils.createProgram(vertexShaderIdFBO,fragmetShaderIdFBO);


        // получаем id атрибутов и юниформ
        _aPositionLocation = GLES20.glGetAttribLocation(_programId, "a_Position");
        _aTexCoordLocation = GLES20.glGetAttribLocation(_programId, "a_TexCoord");

        _uProjMLocation = GLES20.glGetUniformLocation(_programId, "u_ProjM");
        _uModelMLocation = GLES20.glGetUniformLocation(_programId, "u_ModelM");
        _uTextureLocation = GLES20.glGetUniformLocation(_programId, "u_Texture");

        //получеам id юниформы для цвета треугольника в FBO
        _uColorLocation = GLES20.glGetUniformLocation(_programIdFBO,"u_Color");
        _aPositionLocationfbo = GLES20.glGetAttribLocation(_programIdFBO,"a_Position");


        // грузим изображение из ресурсов
        Bitmap image = BitmapFactory.decodeResource(_context.getResources(), R.drawable.cat_2);

        _imgW = image.getWidth();
        _imgH = image.getHeight();

        // инициализируем буферы вершин, индексов и текстурных координат
        float[] verts = arrayFromRectF(new RectF(0, 0, _imgW, _imgH));

        _vertices = ByteBuffer.allocateDirect(verts.length * 4).order(ByteOrder.nativeOrder()).asFloatBuffer();
        _vertices.put(verts);
        _vertices.position(0);

        _indices = ByteBuffer.allocateDirect(verts.length * 2).order(ByteOrder.nativeOrder()).asShortBuffer();
        _indices.put(inds);
        _indices.position(0);

        _texCoords = ByteBuffer.allocateDirect(texCoords.length * 4).order(ByteOrder.nativeOrder()).asFloatBuffer();
        _texCoords.put(texCoords);
        _texCoords.position(0);


        //буфер вершин для FBO
        float[] vertsFBO = new float[]{
                0, 0, 0,
                0, _imgW, 0,
                _imgH, _imgW, 0

        };
        _verticesFbo = ByteBuffer.allocateDirect(verts.length * 4).order(ByteOrder.nativeOrder()).asFloatBuffer();
        _verticesFbo.put(vertsFBO);
        _verticesFbo.position(0);


        // грузим текстуру
        _textureId = TextureUtils.loadTexture(image, true);
        Log.d("TAG","textureIdLoad = "+ _textureId);


        //инициализируем FBO
        initFBO(_imgW,_imgH);
    }

    @Override
    public void onSurfaceChanged(GL10 gl10, int width, int height) {
        _glViewWidth = width;
        _glViewHeight = height;

        Matrix.orthoM(_screenProjM, 0, 0, width, height, 0, 0, 1);

        // вычисляем насколько нужно уменьшить и сдвинуть изображение, чтобы оно влезло в
        // glSurfaceView и было по центру
        float overviewScale = Math.min((float) width / _imgW, (float) height / _imgH);
        float translationX = width / 2.0f - (_imgW / 2.0f) * overviewScale;
        float translationY = height / 2.0f - (_imgH / 2.0f) * overviewScale;

        // задаем матрицу модели
        Matrix.setIdentityM(_modelM, 0);
        Matrix.translateM(_modelM, 0, translationX, translationY, 0);
        Matrix.scaleM(_modelM, 0, overviewScale, overviewScale, 1.0f);
    }

    //матрица для FBO
    private void matrixFBO(int picWidth,int picHeight){
        Matrix.orthoM(_screenProjM,0,0,picWidth,picHeight,0,0,1);
    }

    private void shaderParams() {
        GLES20.glActiveTexture(GLES20.GL_TEXTURE0);
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, _textureId);
        Log.d("TAG","textureId = " + _textureId);

        GLES20.glUniform1i(_uTextureLocation, 0);



        GLES20.glUniformMatrix4fv(_uProjMLocation, 1, false, _screenProjM, 0);
        GLES20.glUniformMatrix4fv(_uModelMLocation, 1, false, _modelM, 0);

        GLES20.glEnableVertexAttribArray(_aPositionLocation);
        GLES20.glVertexAttribPointer(_aPositionLocation, 3, GLES20.GL_FLOAT, false, 0, _vertices);

        GLES20.glEnableVertexAttribArray(_aTexCoordLocation);
        GLES20.glVertexAttribPointer(_aTexCoordLocation, 2, GLES20.GL_FLOAT, false, 0, _texCoords);

        //передаем в шейдеры FBO атрибуты

        GLES20.glEnableVertexAttribArray(_aPositionLocationfbo);
        GLES20.glVertexAttribPointer(_aPositionLocationfbo,3,GL_FLOAT,false,0,_verticesFbo);
    }

    @Override
    public void onDrawFrame(GL10 gl10) {
        GLES20.glViewport(0, 0, _glViewWidth, _glViewHeight);

        GLES20.glClearColor(0, 0, 0, 1);
        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT);

        GLES20.glUseProgram(_programId);

        shaderParams();

        GLES20.glDrawElements(GLES20.GL_TRIANGLES, 6, GLES20.GL_UNSIGNED_SHORT, _indices);
        Log.d("TAG","indlim = "+_indices.limit());

        renderFBO();


    }

    private float[] arrayFromRectF(RectF rect) {
        float x1 = rect.left;
        float x2 = rect.right;
        float y1 = rect.bottom;
        float y2 = rect.top;


        PointF one = new PointF(x1, y2);
        PointF two = new PointF(x1, y1);
        PointF three = new PointF(x2, y1);
        PointF four = new PointF(x2, y2);

        return new float[]
                {
                    one.x, one.y, 0,
                    two.x, two.y, 0,
                    three.x, three.y, 0,
                    four.x, four.y, 0,
                };
    }

    private void initFBO(int width,int height){
        int[] oldFBO = new int[1];
        GLES20.glGetIntegerv(GLES20.GL_FRAMEBUFFER_BINDING, oldFBO, 0);

        int[] temp = new int[1];
        GLES20.glGenFramebuffers(1, temp, 0);
        fboId = temp[0];
        Log.d("TAG","FBOID = "+ fboId);
        //делаем созданный фрейм буфер текущим
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, fboId);
        //генерим id текстуры
        GLES20.glGenTextures(1, temp, 0);
        fboTex = temp[0];
        //делаем созданную текстуру текущей
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, fboTex);
        //определяем двумерную текстуру
        GLES20.glTexImage2D(GLES20.GL_TEXTURE_2D, 0, GLES20.GL_RGBA, width, height, 0, GLES20.GL_RGBA, GLES20.GL_UNSIGNED_BYTE, null);
        //настройки текстуры
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_LINEAR);
        GLES20.glTexParameteri(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_LINEAR);
//прикрепляем текстуру к фрейм буферу
        GLES20.glFramebufferTexture2D(GLES20.GL_FRAMEBUFFER, GLES20.GL_COLOR_ATTACHMENT0, GLES20.GL_TEXTURE_2D, fboTex, 0);
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, 0);
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, oldFBO[0]);


    }
    private void renderFBO(){
        //активируем FBO
        int[] oldFBO = new int[1];
        GLES20.glGetIntegerv(GLES20.GL_FRAMEBUFFER_BINDING, oldFBO, 0);

        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, fboId);
        GLES20.glViewport(0, 0, _imgH,_imgW);

        //задаем новую программу(с шейдарми для FBO)
        glUseProgram(_programIdFBO);
        //обновляем матрицу  для FBO
        matrixFBO(_imgW,_imgH);
        //обновляем шейдеры с учетом новой программы
        shaderParams();


//отрисовка
        //передаем в шейдер цвет
        GLES20.glUniform4f(_uColorLocation,1.0f,0.0f,1.0f,1.0f);
        //рисуем треугольник
        glDrawArrays(GL_TRIANGLES,0,3);
        Log.d("TAG","newIndi = "+ _indices.limit());
        //деактивируем FBO
        GLES20.glBindFramebuffer(GLES20.GL_FRAMEBUFFER, oldFBO[0]);



    }
}