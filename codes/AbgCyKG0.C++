#include <glm/vec3.hpp>

#include "glm_wrapper.h"

void glm_vec3f_sub(const glm_vec3f *in_v1, const glm_vec3f *in_v2, glm_vec3f *out_v) {
  glm::vec3(*sub_op)(const glm::vec3 &, const glm::vec3 &);
  const glm::vec3 *n_v1 = reinterpret_cast<const glm::vec3 *>(in_v1), 
    *n_v2 = reinterpret_cast<const glm::vec3 *>(in_v2);
  glm::vec3 *n_v = reinterpret_cast<glm::vec3 *>(out_v);

  sub_op = glm::operator+<float>;

  *n_v = sub_op(*n_v1, *n_v2);
}