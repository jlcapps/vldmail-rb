#include <wchar.h>
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

    valid_mail_t * c_validation;
    Data_Get_Struct(self, valid_mail_t, c_validation);

    if (RSTRING_LEN(rb_email_string) <= 320) {
        size_t email_length = RSTRING_LEN(rb_email_string) + 1;
        char * mbs_email = StringValuePtr(rb_email_string);
        wchar_t wcs_email[email_length];
        mbstowcs(wcs_email, mbs_email, email_length);
        valid_mail_t result = validate_email(wcs_email);
        c_validation->success = result.success;
        wcscpy(c_validation->message, result.message);
    } else {
        c_validation->success = 0;
        wcscpy(c_validation->message, L"Maximum email length is 320.");
    }

    return self;
}

static VALUE success(VALUE self) {
    valid_mail_t * c_validation;
    Data_Get_Struct(self, valid_mail_t, c_validation);

    if (c_validation->success == 0) {
        return Qfalse;
    } else {
        return Qtrue;
    }
}

static VALUE message(VALUE self) {
    valid_mail_t * c_validation;
    Data_Get_Struct(self, valid_mail_t, c_validation);

    size_t email_length = wcslen(c_validation->message) + 1;
    char mbs_message[email_length];
    wcstombs(mbs_message, c_validation->message, email_length);
    mbs_message[strcspn(mbs_message, "\n")] = '\0'; // strip newline

    return rb_str_new_cstr(mbs_message);
}

void Init_vldmail_validation() {
    VALUE vm_cVldMailValidation = rb_define_class_under(vm_mVldMail, "Validation", rb_cObject);
    rb_define_alloc_func(vm_cVldMailValidation, allocate);
    rb_define_method(vm_cVldMailValidation, "initialize", initialize, 1);
    rb_define_method(vm_cVldMailValidation, "success?", success, 0);
    rb_define_method(vm_cVldMailValidation, "message", message, 0);
}
