#ifndef __GLM_WRAPPER_H__

struct glm_vec3f {
  float r, g, b;
};

#ifdef __cplusplus

extern "C" {

void glm_vec3f_sub(const glm_vec3f *in_v1, const glm_vec3f *in_v2, glm_vec3f *out_v);

}

#elif

typedef struct glm_vec3f glm_vec3f;

#endif // __cplusplus


#endif // !__GLM_WRAPPER_H__