#include "vldmail_validation.h"

static void deallocate(void *c_validation) {
    free(c_validation);
}

static VALUE allocate(VALUE klass) {
    valid_mail_t *c_validation = malloc(sizeof(valid_mail_t));

    return Data_Wrap_Struct(klass, NULL, deallocate, c_validation);
}

void Init_vldmail_validation() {
    VALUE vm_cVldMailValidation = rb_define_class_under(vm_mVldMail, "Validation", rb_cObject);
    rb_define_alloc_func(vm_cVldMailValidation, allocate);
}
