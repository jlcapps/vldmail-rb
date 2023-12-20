#include "vldmail_validation.h"

static void deallocate(void * c_validation) {
    free(c_validation);
}

static VALUE allocate(VALUE klass) {
    valid_mail_t * c_validation = malloc(sizeof(valid_mail_t));

    return Data_Wrap_Struct(klass, NULL, deallocate, c_validation);
}

static VALUE initialize(VALUE self, VALUE rb_email_string) {
    Check_Type(rb_email_string, T_STRING);

    size_t email_length = RSTRING_LEN(rb_email_string) + 1;
    char * mbs_email = StringValuePtr(rb_email_string);
    wchar_t wcs_email[email_length];
    mbstowcs(wcs_email, mbs_email, email_length);
    valid_mail_t * c_validation;
    Data_Get_Struct(self, valid_mail_t, c_validation);
    *c_validation = validate_email(wcs_email);

    return self;
}

static VALUE success(VALUE self) {
    valid_mail_t * c_validation;
    Data_Get_Struct(self, valid_mail_t, c_validation);
    valid_mail_t value = *c_validation;

    if (value.success == 0) {
        return Qfalse;
    } else {
        return Qtrue;
    }
}

void Init_vldmail_validation() {
    VALUE vm_cVldMailValidation = rb_define_class_under(vm_mVldMail, "Validation", rb_cObject);
    rb_define_alloc_func(vm_cVldMailValidation, allocate);
    rb_define_method(vm_cVldMailValidation, "initialize", initialize, 1);
    rb_define_method(vm_cVldMailValidation, "success?", success, 0);
}
