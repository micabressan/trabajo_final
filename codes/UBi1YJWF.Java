/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2015 Guerra24
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

package io.github.guerra24.voxel.client.kernel.graphics;

import static org.lwjgl.opengl.GL11.GL_MODELVIEW_MATRIX;
import static org.lwjgl.opengl.GL11.GL_PROJECTION_MATRIX;
import static org.lwjgl.opengl.GL11.glGetFloat;

import java.nio.FloatBuffer;

import org.lwjgl.BufferUtils;
import org.lwjgl.util.vector.Vector3f;

/**
 * Frustum Culling Old OpenGL Fixed-Func Pipeline
 * 
 * @author Ron Sullivan (modified by Thomas Hourdel)
 *         <thomas.hourdel@libertysurf.fr>
 */
public class Frustum {

	float[][] m_Frustum = new float[6][4];

	/** FloatBuffer to get ModelView matrix. **/
	FloatBuffer modl_b;

	/** FloatBuffer to get Projection matrix. **/
	FloatBuffer proj_b;

	public void normalizePlane(float[][] frustum, int side) {
		float magnitude = (float) Math.sqrt(frustum[side][0] * frustum[side][0] + frustum[side][1] * frustum[side][1] + frustum[side][2] * frustum[side][2]);
		
		for(int i = 0; i < 4; i++)
		{
			frustum[side][i] /= magnitude;
		}
	}

	public void calculateFrustum() {
		float[] proj = new float[16];
		float[] modl = new float[16];
		float[] clip = new float[16];

		proj_b.rewind();
		glGetFloat(GL_PROJECTION_MATRIX, proj_b);
		proj_b.rewind();
		proj_b.get(proj);
		modl_b.rewind();
		glGetFloat(GL_MODELVIEW_MATRIX, modl_b);
		modl_b.rewind();
		modl_b.get(modl);
		
		for(int i = 0; i < 4; i++)
		{
			for(int a = 0; a < 4; a++)
			{
				clip[i * 4 + a] = modl[i * 4] * proj[a] + modl[i * 4 + 1] * proj[a + 4] + modl[i * 4 + 2] * proj[8 + a] + modl[i * 4 + 3] * proj[12 + a];
			}
		}
		
		for(int m = 0; m < 6; m++)
		{
			for(int l = 0; l < 4; l++)
			{
				m_Frustum[m][l] = clip[((l + 1) * 4) - 1] - clip[l * 4];
			}
			normalizePlane(m_Frustum, m);
		}
	}

	public boolean pointInFrustum(float x, float y, float z) {
		for (int i = 0; i < 6; i++) {
			if (m_Frustum[i][0] * x + m_Frustum[i][1] * y + m_Frustum[i][2] * z + m_Frustum[i][3] <= 0) {
				return false;
			}
		}
		return true;
	}

	public boolean sphereInFrustum(float x, float y, float z, float radius) {
		for (int i = 0; i < 6; i++) {
			if (m_Frustum[i][0] * x + m_Frustum[i][1] * y + m_Frustum[i][2] * z + m_Frustum[i][3] <= -radius) {
				return false;
			}
		}

		return true;
	}

	public boolean cubeInFrustum(Vector3f center, float size) {
		return cubeInFrustum(center.x, center.y, center.z, size);
	}

	public boolean cubeInFrustum(float x, float y, float z, float size) {
		for (int i = 0; i < 6; i++) {
			if (m_Frustum[i][0] * (x - size) + m_Frustum[i][1] * (y - size) + m_Frustum[i][2] * (z - size) + m_Frustum[i][3] > 0)
				continue;
			if (m_Frustum[i][0] * (x + size) + m_Frustum[i][1] * (y - size) + m_Frustum[i][2] * (z - size) + m_Frustum[i][3] > 0)
				continue;
			if (m_Frustum[i][0] * (x - size) + m_Frustum[i][1] * (y + size) + m_Frustum[i][2] * (z - size) + m_Frustum[i][3] > 0)
				continue;
			if (m_Frustum[i][0] * (x + size) + m_Frustum[i][1] * (y + size) + m_Frustum[i][2] * (z - size) + m_Frustum[i][3] > 0)
				continue;
			if (m_Frustum[i][0] * (x - size) + m_Frustum[i][1] * (y - size) + m_Frustum[i][2] * (z + size) + m_Frustum[i][3] > 0)
				continue;
			if (m_Frustum[i][0] * (x + size) + m_Frustum[i][1] * (y - size) + m_Frustum[i][2] * (z + size) + m_Frustum[i][3] > 0)
				continue;
			if (m_Frustum[i][0] * (x - size) + m_Frustum[i][1] * (y + size) + m_Frustum[i][2] * (z + size) + m_Frustum[i][3] > 0)
				continue;
			if (m_Frustum[i][0] * (x + size) + m_Frustum[i][1] * (y + size) + m_Frustum[i][2] * (z + size) + m_Frustum[i][3] > 0)
				continue;
			return false;
		}

		return true;
	}

	/**
	 * Frustum constructor, creates FloatBuffer
	 */
	public Frustum() {
		modl_b = BufferUtils.createFloatBuffer(16);
		proj_b = BufferUtils.createFloatBuffer(16);
	}
}