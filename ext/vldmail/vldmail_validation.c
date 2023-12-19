#include "vldmail_validation.h"

void Init_vldmail_validation() {
    VALUE vm_cVldMailValidation = rb_define_class_under(vm_mVldMail, "Validation", rb_cObject);
}
