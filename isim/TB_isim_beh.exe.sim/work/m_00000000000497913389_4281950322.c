/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7dea747 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/BoAdepoju/Desktop/Coding/CECS 440/Robonaut Architecture -- Verilog/v0.61/Robonaut_Architecture/FloatALU.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static int ng3[] = {2, 0};
static int ng4[] = {1, 0, 0, 0};
static int ng5[] = {3, 0};
static int ng6[] = {4, 0};
static int ng7[] = {5, 0};
static int ng8[] = {6, 0};
static int ng9[] = {7, 0};
static int ng10[] = {8, 0};
static int ng11[] = {9, 0};
static int ng12[] = {10, 0};
static int ng13[] = {11, 0};
static int ng14[] = {12, 0};
static int ng15[] = {13, 0};
static unsigned int ng16[] = {4294967295U, 4294967295U, 4294967295U, 4294967295U};



static void Always_25_0(char *t0)
{
    char t4[8];
    char t17[8];
    char t24[16];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    int t9;
    double t10;
    double t11;
    double t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    unsigned int t23;

LAB0:    t1 = (t0 + 3328U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(25, ng0);
    t2 = (t0 + 3648);
    *((int *)t2) = 1;
    t3 = (t0 + 3360);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(25, ng0);

LAB5:    xsi_set_current_line(26, ng0);
    t5 = (t0 + 1048U);
    t6 = *((char **)t5);
    *((int *)t4) = *((int *)t6);
    t5 = (t4 + 4);
    t7 = (t6 + 8);
    *((int *)t5) = *((int *)t7);
    t8 = (t0 + 2248);
    xsi_vlogvar_assign_value_double(t8, *((double *)t4), 0);
    xsi_set_current_line(27, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    *((int *)t4) = *((int *)t3);
    t2 = (t4 + 4);
    t5 = (t3 + 8);
    *((int *)t2) = *((int *)t5);
    t6 = (t0 + 2408);
    xsi_vlogvar_assign_value_double(t6, *((double *)t4), 0);
    xsi_set_current_line(28, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);

LAB6:    t2 = ((char*)((ng1)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB7;

LAB8:    t2 = ((char*)((ng2)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB9;

LAB10:    t2 = ((char*)((ng3)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB11;

LAB12:    t2 = ((char*)((ng5)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB13;

LAB14:    t2 = ((char*)((ng6)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB15;

LAB16:    t2 = ((char*)((ng7)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB17;

LAB18:    t2 = ((char*)((ng8)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB19;

LAB20:    t2 = ((char*)((ng9)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB21;

LAB22:    t2 = ((char*)((ng10)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB23;

LAB24:    t2 = ((char*)((ng11)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB25;

LAB26:    t2 = ((char*)((ng12)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB27;

LAB28:    t2 = ((char*)((ng13)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB29;

LAB30:    t2 = ((char*)((ng14)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB31;

LAB32:    t2 = ((char*)((ng15)));
    t9 = xsi_vlog_unsigned_case_compare(t3, 4, t2, 32);
    if (t9 == 1)
        goto LAB33;

LAB34:
LAB36:
LAB35:    xsi_set_current_line(43, ng0);
    t2 = ((char*)((ng16)));
    t10 = xsi_vlog_convert_to_real(t2, 64, 2);
    t5 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t5, t10, 0);

LAB37:    xsi_set_current_line(46, ng0);
    t2 = (t0 + 2248);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t10 = *((double *)t6);
    t7 = (t0 + 2408);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    t11 = *((double *)t13);
    t16 = (t10 > t11);
    *((unsigned int *)t4) = t16;
    t14 = (t4 + 4);
    *((unsigned int *)t14) = 0U;
    t15 = (t0 + 1928);
    t18 = (t0 + 1928);
    t19 = (t18 + 72U);
    t20 = *((char **)t19);
    t21 = ((char*)((ng7)));
    xsi_vlog_generic_convert_bit_index(t17, t20, 2, t21, 32, 1);
    t22 = (t17 + 4);
    t23 = *((unsigned int *)t22);
    t9 = (!(t23));
    if (t9 == 1)
        goto LAB38;

LAB39:    xsi_set_current_line(47, ng0);
    t2 = (t0 + 2248);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t10 = *((double *)t6);
    t7 = (t0 + 2408);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    t11 = *((double *)t13);
    t16 = (t10 >= t11);
    *((unsigned int *)t4) = t16;
    t14 = (t4 + 4);
    *((unsigned int *)t14) = 0U;
    t15 = (t0 + 1928);
    t18 = (t0 + 1928);
    t19 = (t18 + 72U);
    t20 = *((char **)t19);
    t21 = ((char*)((ng6)));
    xsi_vlog_generic_convert_bit_index(t17, t20, 2, t21, 32, 1);
    t22 = (t17 + 4);
    t23 = *((unsigned int *)t22);
    t9 = (!(t23));
    if (t9 == 1)
        goto LAB40;

LAB41:    xsi_set_current_line(48, ng0);
    t2 = (t0 + 2248);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t10 = *((double *)t6);
    t7 = (t0 + 2408);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    t11 = *((double *)t13);
    t16 = (t10 < t11);
    *((unsigned int *)t4) = t16;
    t14 = (t4 + 4);
    *((unsigned int *)t14) = 0U;
    t15 = (t0 + 1928);
    t18 = (t0 + 1928);
    t19 = (t18 + 72U);
    t20 = *((char **)t19);
    t21 = ((char*)((ng5)));
    xsi_vlog_generic_convert_bit_index(t17, t20, 2, t21, 32, 1);
    t22 = (t17 + 4);
    t23 = *((unsigned int *)t22);
    t9 = (!(t23));
    if (t9 == 1)
        goto LAB42;

LAB43:    xsi_set_current_line(49, ng0);
    t2 = (t0 + 2248);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t10 = *((double *)t6);
    t7 = (t0 + 2408);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    t11 = *((double *)t13);
    t16 = (t10 <= t11);
    *((unsigned int *)t4) = t16;
    t14 = (t4 + 4);
    *((unsigned int *)t14) = 0U;
    t15 = (t0 + 1928);
    t18 = (t0 + 1928);
    t19 = (t18 + 72U);
    t20 = *((char **)t19);
    t21 = ((char*)((ng3)));
    xsi_vlog_generic_convert_bit_index(t17, t20, 2, t21, 32, 1);
    t22 = (t17 + 4);
    t23 = *((unsigned int *)t22);
    t9 = (!(t23));
    if (t9 == 1)
        goto LAB44;

LAB45:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 2248);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t10 = *((double *)t6);
    t7 = (t0 + 2408);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    t11 = *((double *)t13);
    t16 = (t10 == t11);
    *((unsigned int *)t4) = t16;
    t14 = (t4 + 4);
    *((unsigned int *)t14) = 0U;
    t15 = (t0 + 1928);
    t18 = (t0 + 1928);
    t19 = (t18 + 72U);
    t20 = *((char **)t19);
    t21 = ((char*)((ng2)));
    xsi_vlog_generic_convert_bit_index(t17, t20, 2, t21, 32, 1);
    t22 = (t17 + 4);
    t23 = *((unsigned int *)t22);
    t9 = (!(t23));
    if (t9 == 1)
        goto LAB46;

LAB47:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 2248);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t10 = *((double *)t6);
    t7 = (t0 + 2408);
    t8 = (t7 + 56U);
    t13 = *((char **)t8);
    t11 = *((double *)t13);
    t16 = (t10 != t11);
    *((unsigned int *)t4) = t16;
    t14 = (t4 + 4);
    *((unsigned int *)t14) = 0U;
    t15 = (t0 + 1928);
    t18 = (t0 + 1928);
    t19 = (t18 + 72U);
    t20 = *((char **)t19);
    t21 = ((char*)((ng1)));
    xsi_vlog_generic_convert_bit_index(t17, t20, 2, t21, 32, 1);
    t22 = (t17 + 4);
    t23 = *((unsigned int *)t22);
    t9 = (!(t23));
    if (t9 == 1)
        goto LAB48;

LAB49:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 2088);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t10 = *((double *)t6);
    t7 = xsi_vlog_convert_real_to_bits(t10, t24, 64);
    t8 = (t0 + 1768);
    xsi_vlogvar_assign_value(t8, t24, 0, 0, 64);
    goto LAB2;

LAB7:    xsi_set_current_line(29, ng0);
    t5 = (t0 + 2248);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t10 = *((double *)t7);
    t8 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t8, t10, 0);
    goto LAB37;

LAB9:    xsi_set_current_line(30, ng0);
    t5 = (t0 + 2408);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t10 = *((double *)t7);
    t8 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t8, t10, 0);
    goto LAB37;

LAB11:    xsi_set_current_line(31, ng0);
    t5 = (t0 + 2248);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t10 = *((double *)t7);
    t8 = ((char*)((ng4)));
    t11 = xsi_vlog_convert_to_real(t8, 32, 1);
    t12 = (t10 + t11);
    t13 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t13, t12, 0);
    goto LAB37;

LAB13:    xsi_set_current_line(32, ng0);
    t5 = (t0 + 2408);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t10 = *((double *)t7);
    t8 = ((char*)((ng4)));
    t11 = xsi_vlog_convert_to_real(t8, 32, 1);
    t12 = (t10 + t11);
    t13 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t13, t12, 0);
    goto LAB37;

LAB15:    xsi_set_current_line(33, ng0);
    t5 = (t0 + 2248);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t10 = *((double *)t7);
    t8 = ((char*)((ng4)));
    t11 = xsi_vlog_convert_to_real(t8, 32, 1);
    t12 = (t10 - t11);
    t13 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t13, t12, 0);
    goto LAB37;

LAB17:    xsi_set_current_line(34, ng0);
    t5 = (t0 + 2408);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t10 = *((double *)t7);
    t8 = ((char*)((ng4)));
    t11 = xsi_vlog_convert_to_real(t8, 32, 1);
    t12 = (t10 - t11);
    t13 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t13, t12, 0);
    goto LAB37;

LAB19:    xsi_set_current_line(35, ng0);
    t5 = (t0 + 2248);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t10 = *((double *)t7);
    t8 = (t0 + 2408);
    t13 = (t8 + 56U);
    t14 = *((char **)t13);
    t11 = *((double *)t14);
    t12 = (t10 + t11);
    t15 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t15, t12, 0);
    goto LAB37;

LAB21:    xsi_set_current_line(36, ng0);
    t5 = (t0 + 2248);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t10 = *((double *)t7);
    t8 = (t0 + 2408);
    t13 = (t8 + 56U);
    t14 = *((char **)t13);
    t11 = *((double *)t14);
    t12 = (t10 - t11);
    t15 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t15, t12, 0);
    goto LAB37;

LAB23:    xsi_set_current_line(37, ng0);
    t5 = (t0 + 2408);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t10 = *((double *)t7);
    t8 = (t0 + 2248);
    t13 = (t8 + 56U);
    t14 = *((char **)t13);
    t11 = *((double *)t14);
    t12 = (t10 - t11);
    t15 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t15, t12, 0);
    goto LAB37;

LAB25:    xsi_set_current_line(38, ng0);
    t5 = (t0 + 2248);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t10 = *((double *)t7);
    t8 = (t0 + 2408);
    t13 = (t8 + 56U);
    t14 = *((char **)t13);
    t11 = *((double *)t14);
    t12 = (t10 * t11);
    t15 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t15, t12, 0);
    goto LAB37;

LAB27:    xsi_set_current_line(39, ng0);
    t5 = (t0 + 2248);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t10 = *((double *)t7);
    t8 = (t0 + 2408);
    t13 = (t8 + 56U);
    t14 = *((char **)t13);
    t11 = *((double *)t14);
    t12 = (t10 / t11);
    t15 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t15, t12, 0);
    goto LAB37;

LAB29:    xsi_set_current_line(40, ng0);
    t5 = (t0 + 2408);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t10 = *((double *)t7);
    t8 = (t0 + 2248);
    t13 = (t8 + 56U);
    t14 = *((char **)t13);
    t11 = *((double *)t14);
    t12 = (t10 / t11);
    t15 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t15, t12, 0);
    goto LAB37;

LAB31:    xsi_set_current_line(41, ng0);
    t5 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t5, 0.00000000000000000, 0);
    goto LAB37;

LAB33:    xsi_set_current_line(42, ng0);
    t5 = (t0 + 2088);
    xsi_vlogvar_assign_value_double(t5, 1.0000000000000000, 0);
    goto LAB37;

LAB38:    xsi_vlogvar_assign_value(t15, t4, 0, *((unsigned int *)t17), 1);
    goto LAB39;

LAB40:    xsi_vlogvar_assign_value(t15, t4, 0, *((unsigned int *)t17), 1);
    goto LAB41;

LAB42:    xsi_vlogvar_assign_value(t15, t4, 0, *((unsigned int *)t17), 1);
    goto LAB43;

LAB44:    xsi_vlogvar_assign_value(t15, t4, 0, *((unsigned int *)t17), 1);
    goto LAB45;

LAB46:    xsi_vlogvar_assign_value(t15, t4, 0, *((unsigned int *)t17), 1);
    goto LAB47;

LAB48:    xsi_vlogvar_assign_value(t15, t4, 0, *((unsigned int *)t17), 1);
    goto LAB49;

}


extern void work_m_00000000000497913389_4281950322_init()
{
	static char *pe[] = {(void *)Always_25_0};
	xsi_register_didat("work_m_00000000000497913389_4281950322", "isim/TB_isim_beh.exe.sim/work/m_00000000000497913389_4281950322.didat");
	xsi_register_executes(pe);
}
