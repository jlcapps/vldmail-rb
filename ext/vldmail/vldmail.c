#include "vldmail.h"

VALUE vm_mVldMail;

void Init_vldmail() {
    vm_mVldMail = rb_define_module("VldMail");

    Init_vldmail_validation();
}
