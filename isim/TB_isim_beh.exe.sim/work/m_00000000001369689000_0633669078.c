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
static const char *ng0 = "C:/Users/BoAdepoju/Desktop/Coding/CECS 440/Robonaut Architecture -- Verilog/v0.61/Robonaut_Architecture/VectorALU16.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {1U, 0U};
static unsigned int ng3[] = {2U, 0U};
static unsigned int ng4[] = {3U, 0U};
static unsigned int ng5[] = {4U, 0U};
static unsigned int ng6[] = {5U, 0U};
static unsigned int ng7[] = {6U, 0U};
static unsigned int ng8[] = {32768U, 0U};
static unsigned int ng9[] = {32767U, 0U};
static unsigned int ng10[] = {7U, 0U};
static unsigned int ng11[] = {8U, 0U};
static int ng12[] = {16, 0};
static int ng13[] = {31, 0};
static int ng14[] = {1, 0};
static unsigned int ng15[] = {9U, 0U};
static unsigned int ng16[] = {10U, 0U};
static unsigned int ng17[] = {65535U, 0U};
static unsigned int ng18[] = {11U, 0U};



static void Always_34_0(char *t0)
{
    char t10[8];
    char t40[8];
    char t41[8];
    char t48[8];
    char t57[8];
    char t73[8];
    char t81[8];
    char t111[8];
    char t126[8];
    char t127[8];
    char t131[8];
    char t139[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    int t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    char *t39;
    char *t42;
    char *t43;
    unsigned int t44;
    unsigned int t45;
    char *t46;
    char *t47;
    char *t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    char *t56;
    char *t58;
    char *t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    char *t72;
    char *t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    char *t80;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    char *t85;
    char *t86;
    char *t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    unsigned int t94;
    char *t95;
    char *t96;
    unsigned int t97;
    unsigned int t98;
    unsigned int t99;
    unsigned int t100;
    unsigned int t101;
    unsigned int t102;
    unsigned int t103;
    unsigned int t104;
    unsigned int t105;
    unsigned int t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    unsigned int t110;
    char *t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    char *t118;
    char *t119;
    unsigned int t120;
    unsigned int t121;
    unsigned int t122;
    char *t123;
    char *t124;
    char *t125;
    char *t128;
    char *t129;
    char *t130;
    char *t132;
    unsigned int t133;
    unsigned int t134;
    unsigned int t135;
    unsigned int t136;
    unsigned int t137;
    char *t138;
    unsigned int t140;
    unsigned int t141;
    unsigned int t142;
    char *t143;
    char *t144;
    char *t145;
    unsigned int t146;
    unsigned int t147;
    unsigned int t148;
    unsigned int t149;
    unsigned int t150;
    unsigned int t151;
    unsigned int t152;
    char *t153;
    char *t154;
    unsigned int t155;
    unsigned int t156;
    unsigned int t157;
    unsigned int t158;
    unsigned int t159;
    unsigned int t160;
    unsigned int t161;
    unsigned int t162;
    int t163;
    int t164;
    unsigned int t165;
    unsigned int t166;
    unsigned int t167;
    unsigned int t168;
    unsigned int t169;
    unsigned int t170;
    char *t171;
    unsigned int t172;
    unsigned int t173;
    unsigned int t174;
    unsigned int t175;
    unsigned int t176;
    char *t177;
    char *t178;
    int t179;
    int t180;
    int t181;
    int t182;

LAB0:    t1 = (t0 + 3168U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 3488);
    *((int *)t2) = 1;
    t3 = (t0 + 3200);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(35, ng0);

LAB5:    xsi_set_current_line(36, ng0);
    t4 = (t0 + 1368U);
    t5 = *((char **)t4);

LAB6:    t4 = ((char*)((ng1)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t4, 5);
    if (t6 == 1)
        goto LAB7;

LAB8:    t2 = ((char*)((ng2)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB9;

LAB10:    t2 = ((char*)((ng3)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB11;

LAB12:    t2 = ((char*)((ng4)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB13;

LAB14:    t2 = ((char*)((ng5)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB15;

LAB16:    t2 = ((char*)((ng6)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB17;

LAB18:    t2 = ((char*)((ng7)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB19;

LAB20:    t2 = ((char*)((ng10)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB21;

LAB22:    t2 = ((char*)((ng11)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB23;

LAB24:    t2 = ((char*)((ng15)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB25;

LAB26:    t2 = ((char*)((ng16)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB27;

LAB28:    t2 = ((char*)((ng18)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB29;

LAB30:
LAB32:
LAB31:    xsi_set_current_line(176, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    t2 = (t0 + 1768);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 16);

LAB33:    goto LAB2;

LAB7:    xsi_set_current_line(38, ng0);
    t7 = (t0 + 1048U);
    t8 = *((char **)t7);
    t7 = (t0 + 1208U);
    t9 = *((char **)t7);
    memset(t10, 0, 8);
    xsi_vlog_unsigned_add(t10, 16, t8, 16, t9, 16);
    t7 = (t0 + 1768);
    xsi_vlogvar_assign_value(t7, t10, 0, 0, 16);
    goto LAB33;

LAB9:    xsi_set_current_line(40, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t4, 0, 0, 16);
    goto LAB33;

LAB11:    xsi_set_current_line(42, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    memset(t10, 0, 8);
    xsi_vlog_unsigned_minus(t10, 16, t4, 16, t7, 16);
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t10, 0, 0, 16);
    goto LAB33;

LAB13:    xsi_set_current_line(44, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    t11 = *((unsigned int *)t4);
    t12 = *((unsigned int *)t7);
    t13 = (t11 & t12);
    *((unsigned int *)t10) = t13;
    t3 = (t4 + 4);
    t8 = (t7 + 4);
    t9 = (t10 + 4);
    t14 = *((unsigned int *)t3);
    t15 = *((unsigned int *)t8);
    t16 = (t14 | t15);
    *((unsigned int *)t9) = t16;
    t17 = *((unsigned int *)t9);
    t18 = (t17 != 0);
    if (t18 == 1)
        goto LAB34;

LAB35:
LAB36:    t39 = (t0 + 1768);
    xsi_vlogvar_assign_value(t39, t10, 0, 0, 16);
    goto LAB33;

LAB15:    xsi_set_current_line(46, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    t11 = *((unsigned int *)t4);
    t12 = *((unsigned int *)t7);
    t13 = (t11 | t12);
    *((unsigned int *)t10) = t13;
    t3 = (t4 + 4);
    t8 = (t7 + 4);
    t9 = (t10 + 4);
    t14 = *((unsigned int *)t3);
    t15 = *((unsigned int *)t8);
    t16 = (t14 | t15);
    *((unsigned int *)t9) = t16;
    t17 = *((unsigned int *)t9);
    t18 = (t17 != 0);
    if (t18 == 1)
        goto LAB37;

LAB38:
LAB39:    t39 = (t0 + 1768);
    xsi_vlogvar_assign_value(t39, t10, 0, 0, 16);
    goto LAB33;

LAB17:    xsi_set_current_line(48, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    t11 = *((unsigned int *)t4);
    t12 = *((unsigned int *)t7);
    t13 = (t11 ^ t12);
    *((unsigned int *)t10) = t13;
    t3 = (t4 + 4);
    t8 = (t7 + 4);
    t9 = (t10 + 4);
    t14 = *((unsigned int *)t3);
    t15 = *((unsigned int *)t8);
    t16 = (t14 | t15);
    *((unsigned int *)t9) = t16;
    t17 = *((unsigned int *)t9);
    t18 = (t17 != 0);
    if (t18 == 1)
        goto LAB40;

LAB41:
LAB42:    t21 = (t0 + 1768);
    xsi_vlogvar_assign_value(t21, t10, 0, 0, 16);
    goto LAB33;

LAB19:    xsi_set_current_line(50, ng0);

LAB43:    xsi_set_current_line(52, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    memset(t10, 0, 8);
    t3 = (t10 + 4);
    t7 = (t4 + 4);
    t11 = *((unsigned int *)t4);
    t12 = (t11 >> 15);
    t13 = (t12 & 1);
    *((unsigned int *)t10) = t13;
    t14 = *((unsigned int *)t7);
    t15 = (t14 >> 15);
    t16 = (t15 & 1);
    *((unsigned int *)t3) = t16;
    t8 = ((char*)((ng1)));
    memset(t40, 0, 8);
    t9 = (t10 + 4);
    t21 = (t8 + 4);
    t17 = *((unsigned int *)t10);
    t18 = *((unsigned int *)t8);
    t19 = (t17 ^ t18);
    t20 = *((unsigned int *)t9);
    t23 = *((unsigned int *)t21);
    t24 = (t20 ^ t23);
    t25 = (t19 | t24);
    t26 = *((unsigned int *)t9);
    t27 = *((unsigned int *)t21);
    t28 = (t26 | t27);
    t29 = (~(t28));
    t30 = (t25 & t29);
    if (t30 != 0)
        goto LAB47;

LAB44:    if (t28 != 0)
        goto LAB46;

LAB45:    *((unsigned int *)t40) = 1;

LAB47:    memset(t41, 0, 8);
    t39 = (t40 + 4);
    t33 = *((unsigned int *)t39);
    t34 = (~(t33));
    t35 = *((unsigned int *)t40);
    t36 = (t35 & t34);
    t37 = (t36 & 1U);
    if (t37 != 0)
        goto LAB48;

LAB49:    if (*((unsigned int *)t39) != 0)
        goto LAB50;

LAB51:    t43 = (t41 + 4);
    t38 = *((unsigned int *)t41);
    t44 = *((unsigned int *)t43);
    t45 = (t38 || t44);
    if (t45 > 0)
        goto LAB52;

LAB53:    memcpy(t81, t41, 8);

LAB54:    memset(t111, 0, 8);
    t112 = (t81 + 4);
    t113 = *((unsigned int *)t112);
    t114 = (~(t113));
    t115 = *((unsigned int *)t81);
    t116 = (t115 & t114);
    t117 = (t116 & 1U);
    if (t117 != 0)
        goto LAB66;

LAB67:    if (*((unsigned int *)t112) != 0)
        goto LAB68;

LAB69:    t119 = (t111 + 4);
    t120 = *((unsigned int *)t111);
    t121 = *((unsigned int *)t119);
    t122 = (t120 || t121);
    if (t122 > 0)
        goto LAB70;

LAB71:    memcpy(t139, t111, 8);

LAB72:    t171 = (t139 + 4);
    t172 = *((unsigned int *)t171);
    t173 = (~(t172));
    t174 = *((unsigned int *)t139);
    t175 = (t174 & t173);
    t176 = (t175 != 0);
    if (t176 > 0)
        goto LAB85;

LAB86:    xsi_set_current_line(56, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    memset(t10, 0, 8);
    t2 = (t10 + 4);
    t4 = (t3 + 4);
    t11 = *((unsigned int *)t3);
    t12 = (t11 >> 15);
    t13 = (t12 & 1);
    *((unsigned int *)t10) = t13;
    t14 = *((unsigned int *)t4);
    t15 = (t14 >> 15);
    t16 = (t15 & 1);
    *((unsigned int *)t2) = t16;
    t7 = ((char*)((ng2)));
    memset(t40, 0, 8);
    t8 = (t10 + 4);
    t9 = (t7 + 4);
    t17 = *((unsigned int *)t10);
    t18 = *((unsigned int *)t7);
    t19 = (t17 ^ t18);
    t20 = *((unsigned int *)t8);
    t23 = *((unsigned int *)t9);
    t24 = (t20 ^ t23);
    t25 = (t19 | t24);
    t26 = *((unsigned int *)t8);
    t27 = *((unsigned int *)t9);
    t28 = (t26 | t27);
    t29 = (~(t28));
    t30 = (t25 & t29);
    if (t30 != 0)
        goto LAB92;

LAB89:    if (t28 != 0)
        goto LAB91;

LAB90:    *((unsigned int *)t40) = 1;

LAB92:    memset(t41, 0, 8);
    t22 = (t40 + 4);
    t33 = *((unsigned int *)t22);
    t34 = (~(t33));
    t35 = *((unsigned int *)t40);
    t36 = (t35 & t34);
    t37 = (t36 & 1U);
    if (t37 != 0)
        goto LAB93;

LAB94:    if (*((unsigned int *)t22) != 0)
        goto LAB95;

LAB96:    t42 = (t41 + 4);
    t38 = *((unsigned int *)t41);
    t44 = *((unsigned int *)t42);
    t45 = (t38 || t44);
    if (t45 > 0)
        goto LAB97;

LAB98:    memcpy(t81, t41, 8);

LAB99:    memset(t111, 0, 8);
    t96 = (t81 + 4);
    t113 = *((unsigned int *)t96);
    t114 = (~(t113));
    t115 = *((unsigned int *)t81);
    t116 = (t115 & t114);
    t117 = (t116 & 1U);
    if (t117 != 0)
        goto LAB111;

LAB112:    if (*((unsigned int *)t96) != 0)
        goto LAB113;

LAB114:    t118 = (t111 + 4);
    t120 = *((unsigned int *)t111);
    t121 = *((unsigned int *)t118);
    t122 = (t120 || t121);
    if (t122 > 0)
        goto LAB115;

LAB116:    memcpy(t139, t111, 8);

LAB117:    t154 = (t139 + 4);
    t172 = *((unsigned int *)t154);
    t173 = (~(t172));
    t174 = *((unsigned int *)t139);
    t175 = (t174 & t173);
    t176 = (t175 != 0);
    if (t176 > 0)
        goto LAB130;

LAB131:    xsi_set_current_line(61, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = (t0 + 1208U);
    t4 = *((char **)t2);
    memset(t10, 0, 8);
    xsi_vlog_unsigned_add(t10, 16, t3, 16, t4, 16);
    t2 = (t0 + 1768);
    xsi_vlogvar_assign_value(t2, t10, 0, 0, 16);

LAB132:
LAB87:    goto LAB33;

LAB21:    xsi_set_current_line(65, ng0);

LAB134:    xsi_set_current_line(66, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    memset(t10, 0, 8);
    t3 = (t10 + 4);
    t7 = (t4 + 4);
    t11 = *((unsigned int *)t4);
    t12 = (t11 >> 15);
    t13 = (t12 & 1);
    *((unsigned int *)t10) = t13;
    t14 = *((unsigned int *)t7);
    t15 = (t14 >> 15);
    t16 = (t15 & 1);
    *((unsigned int *)t3) = t16;
    t8 = ((char*)((ng1)));
    memset(t40, 0, 8);
    t9 = (t10 + 4);
    t21 = (t8 + 4);
    t17 = *((unsigned int *)t10);
    t18 = *((unsigned int *)t8);
    t19 = (t17 ^ t18);
    t20 = *((unsigned int *)t9);
    t23 = *((unsigned int *)t21);
    t24 = (t20 ^ t23);
    t25 = (t19 | t24);
    t26 = *((unsigned int *)t9);
    t27 = *((unsigned int *)t21);
    t28 = (t26 | t27);
    t29 = (~(t28));
    t30 = (t25 & t29);
    if (t30 != 0)
        goto LAB138;

LAB135:    if (t28 != 0)
        goto LAB137;

LAB136:    *((unsigned int *)t40) = 1;

LAB138:    memset(t41, 0, 8);
    t39 = (t40 + 4);
    t33 = *((unsigned int *)t39);
    t34 = (~(t33));
    t35 = *((unsigned int *)t40);
    t36 = (t35 & t34);
    t37 = (t36 & 1U);
    if (t37 != 0)
        goto LAB139;

LAB140:    if (*((unsigned int *)t39) != 0)
        goto LAB141;

LAB142:    t43 = (t41 + 4);
    t38 = *((unsigned int *)t41);
    t44 = *((unsigned int *)t43);
    t45 = (t38 || t44);
    if (t45 > 0)
        goto LAB143;

LAB144:    memcpy(t81, t41, 8);

LAB145:    memset(t111, 0, 8);
    t112 = (t81 + 4);
    t113 = *((unsigned int *)t112);
    t114 = (~(t113));
    t115 = *((unsigned int *)t81);
    t116 = (t115 & t114);
    t117 = (t116 & 1U);
    if (t117 != 0)
        goto LAB157;

LAB158:    if (*((unsigned int *)t112) != 0)
        goto LAB159;

LAB160:    t119 = (t111 + 4);
    t120 = *((unsigned int *)t111);
    t121 = *((unsigned int *)t119);
    t122 = (t120 || t121);
    if (t122 > 0)
        goto LAB161;

LAB162:    memcpy(t139, t111, 8);

LAB163:    t171 = (t139 + 4);
    t172 = *((unsigned int *)t171);
    t173 = (~(t172));
    t174 = *((unsigned int *)t139);
    t175 = (t174 & t173);
    t176 = (t175 != 0);
    if (t176 > 0)
        goto LAB176;

LAB177:    xsi_set_current_line(68, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    memset(t10, 0, 8);
    t2 = (t10 + 4);
    t4 = (t3 + 4);
    t11 = *((unsigned int *)t3);
    t12 = (t11 >> 15);
    t13 = (t12 & 1);
    *((unsigned int *)t10) = t13;
    t14 = *((unsigned int *)t4);
    t15 = (t14 >> 15);
    t16 = (t15 & 1);
    *((unsigned int *)t2) = t16;
    t7 = ((char*)((ng2)));
    memset(t40, 0, 8);
    t8 = (t10 + 4);
    t9 = (t7 + 4);
    t17 = *((unsigned int *)t10);
    t18 = *((unsigned int *)t7);
    t19 = (t17 ^ t18);
    t20 = *((unsigned int *)t8);
    t23 = *((unsigned int *)t9);
    t24 = (t20 ^ t23);
    t25 = (t19 | t24);
    t26 = *((unsigned int *)t8);
    t27 = *((unsigned int *)t9);
    t28 = (t26 | t27);
    t29 = (~(t28));
    t30 = (t25 & t29);
    if (t30 != 0)
        goto LAB182;

LAB179:    if (t28 != 0)
        goto LAB181;

LAB180:    *((unsigned int *)t40) = 1;

LAB182:    memset(t41, 0, 8);
    t22 = (t40 + 4);
    t33 = *((unsigned int *)t22);
    t34 = (~(t33));
    t35 = *((unsigned int *)t40);
    t36 = (t35 & t34);
    t37 = (t36 & 1U);
    if (t37 != 0)
        goto LAB183;

LAB184:    if (*((unsigned int *)t22) != 0)
        goto LAB185;

LAB186:    t42 = (t41 + 4);
    t38 = *((unsigned int *)t41);
    t44 = *((unsigned int *)t42);
    t45 = (t38 || t44);
    if (t45 > 0)
        goto LAB187;

LAB188:    memcpy(t81, t41, 8);

LAB189:    memset(t111, 0, 8);
    t96 = (t81 + 4);
    t113 = *((unsigned int *)t96);
    t114 = (~(t113));
    t115 = *((unsigned int *)t81);
    t116 = (t115 & t114);
    t117 = (t116 & 1U);
    if (t117 != 0)
        goto LAB201;

LAB202:    if (*((unsigned int *)t96) != 0)
        goto LAB203;

LAB204:    t118 = (t111 + 4);
    t120 = *((unsigned int *)t111);
    t121 = *((unsigned int *)t118);
    t122 = (t120 || t121);
    if (t122 > 0)
        goto LAB205;

LAB206:    memcpy(t139, t111, 8);

LAB207:    t154 = (t139 + 4);
    t172 = *((unsigned int *)t154);
    t173 = (~(t172));
    t174 = *((unsigned int *)t139);
    t175 = (t174 & t173);
    t176 = (t175 != 0);
    if (t176 > 0)
        goto LAB220;

LAB221:    xsi_set_current_line(71, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = (t0 + 1208U);
    t4 = *((char **)t2);
    memset(t10, 0, 8);
    xsi_vlog_unsigned_minus(t10, 16, t3, 16, t4, 16);
    t2 = (t0 + 1768);
    xsi_vlogvar_assign_value(t2, t10, 0, 0, 16);

LAB222:
LAB178:    goto LAB33;

LAB23:    xsi_set_current_line(76, ng0);

LAB223:    xsi_set_current_line(77, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    memset(t40, 0, 8);
    t3 = (t40 + 4);
    t7 = (t4 + 4);
    t11 = *((unsigned int *)t4);
    t12 = (t11 >> 15);
    t13 = (t12 & 1);
    *((unsigned int *)t40) = t13;
    t14 = *((unsigned int *)t7);
    t15 = (t14 >> 15);
    t16 = (t15 & 1);
    *((unsigned int *)t3) = t16;
    t8 = (t0 + 1048U);
    t9 = *((char **)t8);
    memset(t41, 0, 8);
    t8 = (t41 + 4);
    t21 = (t9 + 4);
    t17 = *((unsigned int *)t9);
    t18 = (t17 >> 15);
    t19 = (t18 & 1);
    *((unsigned int *)t41) = t19;
    t20 = *((unsigned int *)t21);
    t23 = (t20 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t8) = t24;
    xsi_vlogtype_concat(t10, 2, 2, 2U, t41, 1, t40, 1);

LAB224:    t22 = ((char*)((ng1)));
    t31 = xsi_vlog_unsigned_case_compare(t10, 2, t22, 2);
    if (t31 == 1)
        goto LAB225;

LAB226:    t2 = ((char*)((ng2)));
    t6 = xsi_vlog_unsigned_case_compare(t10, 2, t2, 2);
    if (t6 == 1)
        goto LAB227;

LAB228:    t2 = ((char*)((ng3)));
    t6 = xsi_vlog_unsigned_case_compare(t10, 2, t2, 2);
    if (t6 == 1)
        goto LAB229;

LAB230:    t2 = ((char*)((ng4)));
    t6 = xsi_vlog_unsigned_case_compare(t10, 2, t2, 2);
    if (t6 == 1)
        goto LAB231;

LAB232:
LAB233:    goto LAB33;

LAB25:    xsi_set_current_line(162, ng0);
    t3 = (t0 + 2088);
    t4 = (t3 + 56U);
    t7 = *((char **)t4);
    memset(t40, 0, 8);
    t8 = (t40 + 4);
    t9 = (t7 + 4);
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t40) = t12;
    t13 = *((unsigned int *)t9);
    t14 = (t13 >> 0);
    *((unsigned int *)t8) = t14;
    t15 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t15 & 4294967295U);
    t16 = *((unsigned int *)t8);
    *((unsigned int *)t8) = (t16 & 4294967295U);
    t21 = (t0 + 1928);
    xsi_vlogvar_assign_value(t21, t40, 0, 0, 32);
    goto LAB33;

LAB27:    xsi_set_current_line(164, ng0);

LAB302:    xsi_set_current_line(165, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    t11 = *((unsigned int *)t4);
    t12 = *((unsigned int *)t7);
    t13 = (t11 & t12);
    *((unsigned int *)t40) = t13;
    t3 = (t4 + 4);
    t8 = (t7 + 4);
    t9 = (t40 + 4);
    t14 = *((unsigned int *)t3);
    t15 = *((unsigned int *)t8);
    t16 = (t14 | t15);
    *((unsigned int *)t9) = t16;
    t17 = *((unsigned int *)t9);
    t18 = (t17 != 0);
    if (t18 == 1)
        goto LAB303;

LAB304:
LAB305:    t39 = (t0 + 1048U);
    t42 = *((char **)t39);
    memset(t41, 0, 8);
    t39 = (t40 + 4);
    t43 = (t42 + 4);
    t44 = *((unsigned int *)t40);
    t45 = *((unsigned int *)t42);
    t50 = (t44 ^ t45);
    t51 = *((unsigned int *)t39);
    t52 = *((unsigned int *)t43);
    t53 = (t51 ^ t52);
    t54 = (t50 | t53);
    t55 = *((unsigned int *)t39);
    t60 = *((unsigned int *)t43);
    t61 = (t55 | t60);
    t62 = (~(t61));
    t63 = (t54 & t62);
    if (t63 != 0)
        goto LAB309;

LAB306:    if (t61 != 0)
        goto LAB308;

LAB307:    *((unsigned int *)t41) = 1;

LAB309:    t47 = (t41 + 4);
    t64 = *((unsigned int *)t47);
    t65 = (~(t64));
    t66 = *((unsigned int *)t41);
    t67 = (t66 & t65);
    t68 = (t67 != 0);
    if (t68 > 0)
        goto LAB310;

LAB311:    xsi_set_current_line(170, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 16);

LAB312:    goto LAB33;

LAB29:    xsi_set_current_line(173, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t4, 0, 0, 16);
    goto LAB33;

LAB34:    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t9);
    *((unsigned int *)t10) = (t19 | t20);
    t21 = (t4 + 4);
    t22 = (t7 + 4);
    t23 = *((unsigned int *)t4);
    t24 = (~(t23));
    t25 = *((unsigned int *)t21);
    t26 = (~(t25));
    t27 = *((unsigned int *)t7);
    t28 = (~(t27));
    t29 = *((unsigned int *)t22);
    t30 = (~(t29));
    t31 = (t24 & t26);
    t32 = (t28 & t30);
    t33 = (~(t31));
    t34 = (~(t32));
    t35 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t35 & t33);
    t36 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t36 & t34);
    t37 = *((unsigned int *)t10);
    *((unsigned int *)t10) = (t37 & t33);
    t38 = *((unsigned int *)t10);
    *((unsigned int *)t10) = (t38 & t34);
    goto LAB36;

LAB37:    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t9);
    *((unsigned int *)t10) = (t19 | t20);
    t21 = (t4 + 4);
    t22 = (t7 + 4);
    t23 = *((unsigned int *)t21);
    t24 = (~(t23));
    t25 = *((unsigned int *)t4);
    t31 = (t25 & t24);
    t26 = *((unsigned int *)t22);
    t27 = (~(t26));
    t28 = *((unsigned int *)t7);
    t32 = (t28 & t27);
    t29 = (~(t31));
    t30 = (~(t32));
    t33 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t33 & t29);
    t34 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t34 & t30);
    goto LAB39;

LAB40:    t19 = *((unsigned int *)t10);
    t20 = *((unsigned int *)t9);
    *((unsigned int *)t10) = (t19 | t20);
    goto LAB42;

LAB46:    t22 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t22) = 1;
    goto LAB47;

LAB48:    *((unsigned int *)t41) = 1;
    goto LAB51;

LAB50:    t42 = (t41 + 4);
    *((unsigned int *)t41) = 1;
    *((unsigned int *)t42) = 1;
    goto LAB51;

LAB52:    t46 = (t0 + 1208U);
    t47 = *((char **)t46);
    memset(t48, 0, 8);
    t46 = (t48 + 4);
    t49 = (t47 + 4);
    t50 = *((unsigned int *)t47);
    t51 = (t50 >> 15);
    t52 = (t51 & 1);
    *((unsigned int *)t48) = t52;
    t53 = *((unsigned int *)t49);
    t54 = (t53 >> 15);
    t55 = (t54 & 1);
    *((unsigned int *)t46) = t55;
    t56 = ((char*)((ng1)));
    memset(t57, 0, 8);
    t58 = (t48 + 4);
    t59 = (t56 + 4);
    t60 = *((unsigned int *)t48);
    t61 = *((unsigned int *)t56);
    t62 = (t60 ^ t61);
    t63 = *((unsigned int *)t58);
    t64 = *((unsigned int *)t59);
    t65 = (t63 ^ t64);
    t66 = (t62 | t65);
    t67 = *((unsigned int *)t58);
    t68 = *((unsigned int *)t59);
    t69 = (t67 | t68);
    t70 = (~(t69));
    t71 = (t66 & t70);
    if (t71 != 0)
        goto LAB58;

LAB55:    if (t69 != 0)
        goto LAB57;

LAB56:    *((unsigned int *)t57) = 1;

LAB58:    memset(t73, 0, 8);
    t74 = (t57 + 4);
    t75 = *((unsigned int *)t74);
    t76 = (~(t75));
    t77 = *((unsigned int *)t57);
    t78 = (t77 & t76);
    t79 = (t78 & 1U);
    if (t79 != 0)
        goto LAB59;

LAB60:    if (*((unsigned int *)t74) != 0)
        goto LAB61;

LAB62:    t82 = *((unsigned int *)t41);
    t83 = *((unsigned int *)t73);
    t84 = (t82 & t83);
    *((unsigned int *)t81) = t84;
    t85 = (t41 + 4);
    t86 = (t73 + 4);
    t87 = (t81 + 4);
    t88 = *((unsigned int *)t85);
    t89 = *((unsigned int *)t86);
    t90 = (t88 | t89);
    *((unsigned int *)t87) = t90;
    t91 = *((unsigned int *)t87);
    t92 = (t91 != 0);
    if (t92 == 1)
        goto LAB63;

LAB64:
LAB65:    goto LAB54;

LAB57:    t72 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t72) = 1;
    goto LAB58;

LAB59:    *((unsigned int *)t73) = 1;
    goto LAB62;

LAB61:    t80 = (t73 + 4);
    *((unsigned int *)t73) = 1;
    *((unsigned int *)t80) = 1;
    goto LAB62;

LAB63:    t93 = *((unsigned int *)t81);
    t94 = *((unsigned int *)t87);
    *((unsigned int *)t81) = (t93 | t94);
    t95 = (t41 + 4);
    t96 = (t73 + 4);
    t97 = *((unsigned int *)t41);
    t98 = (~(t97));
    t99 = *((unsigned int *)t95);
    t100 = (~(t99));
    t101 = *((unsigned int *)t73);
    t102 = (~(t101));
    t103 = *((unsigned int *)t96);
    t104 = (~(t103));
    t31 = (t98 & t100);
    t32 = (t102 & t104);
    t105 = (~(t31));
    t106 = (~(t32));
    t107 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t107 & t105);
    t108 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t108 & t106);
    t109 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t109 & t105);
    t110 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t110 & t106);
    goto LAB65;

LAB66:    *((unsigned int *)t111) = 1;
    goto LAB69;

LAB68:    t118 = (t111 + 4);
    *((unsigned int *)t111) = 1;
    *((unsigned int *)t118) = 1;
    goto LAB69;

LAB70:    t123 = (t0 + 1048U);
    t124 = *((char **)t123);
    t123 = (t0 + 1208U);
    t125 = *((char **)t123);
    memset(t126, 0, 8);
    xsi_vlog_unsigned_add(t126, 16, t124, 16, t125, 16);
    t123 = ((char*)((ng8)));
    memset(t127, 0, 8);
    t128 = (t126 + 4);
    if (*((unsigned int *)t128) != 0)
        goto LAB74;

LAB73:    t129 = (t123 + 4);
    if (*((unsigned int *)t129) != 0)
        goto LAB74;

LAB77:    if (*((unsigned int *)t126) < *((unsigned int *)t123))
        goto LAB76;

LAB75:    *((unsigned int *)t127) = 1;

LAB76:    memset(t131, 0, 8);
    t132 = (t127 + 4);
    t133 = *((unsigned int *)t132);
    t134 = (~(t133));
    t135 = *((unsigned int *)t127);
    t136 = (t135 & t134);
    t137 = (t136 & 1U);
    if (t137 != 0)
        goto LAB78;

LAB79:    if (*((unsigned int *)t132) != 0)
        goto LAB80;

LAB81:    t140 = *((unsigned int *)t111);
    t141 = *((unsigned int *)t131);
    t142 = (t140 & t141);
    *((unsigned int *)t139) = t142;
    t143 = (t111 + 4);
    t144 = (t131 + 4);
    t145 = (t139 + 4);
    t146 = *((unsigned int *)t143);
    t147 = *((unsigned int *)t144);
    t148 = (t146 | t147);
    *((unsigned int *)t145) = t148;
    t149 = *((unsigned int *)t145);
    t150 = (t149 != 0);
    if (t150 == 1)
        goto LAB82;

LAB83:
LAB84:    goto LAB72;

LAB74:    t130 = (t127 + 4);
    *((unsigned int *)t127) = 1;
    *((unsigned int *)t130) = 1;
    goto LAB76;

LAB78:    *((unsigned int *)t131) = 1;
    goto LAB81;

LAB80:    t138 = (t131 + 4);
    *((unsigned int *)t131) = 1;
    *((unsigned int *)t138) = 1;
    goto LAB81;

LAB82:    t151 = *((unsigned int *)t139);
    t152 = *((unsigned int *)t145);
    *((unsigned int *)t139) = (t151 | t152);
    t153 = (t111 + 4);
    t154 = (t131 + 4);
    t155 = *((unsigned int *)t111);
    t156 = (~(t155));
    t157 = *((unsigned int *)t153);
    t158 = (~(t157));
    t159 = *((unsigned int *)t131);
    t160 = (~(t159));
    t161 = *((unsigned int *)t154);
    t162 = (~(t161));
    t163 = (t156 & t158);
    t164 = (t160 & t162);
    t165 = (~(t163));
    t166 = (~(t164));
    t167 = *((unsigned int *)t145);
    *((unsigned int *)t145) = (t167 & t165);
    t168 = *((unsigned int *)t145);
    *((unsigned int *)t145) = (t168 & t166);
    t169 = *((unsigned int *)t139);
    *((unsigned int *)t139) = (t169 & t165);
    t170 = *((unsigned int *)t139);
    *((unsigned int *)t139) = (t170 & t166);
    goto LAB84;

LAB85:    xsi_set_current_line(53, ng0);

LAB88:    xsi_set_current_line(54, ng0);
    t177 = ((char*)((ng9)));
    t178 = (t0 + 1768);
    xsi_vlogvar_assign_value(t178, t177, 0, 0, 16);
    goto LAB87;

LAB91:    t21 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB92;

LAB93:    *((unsigned int *)t41) = 1;
    goto LAB96;

LAB95:    t39 = (t41 + 4);
    *((unsigned int *)t41) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB96;

LAB97:    t43 = (t0 + 1208U);
    t46 = *((char **)t43);
    memset(t48, 0, 8);
    t43 = (t48 + 4);
    t47 = (t46 + 4);
    t50 = *((unsigned int *)t46);
    t51 = (t50 >> 15);
    t52 = (t51 & 1);
    *((unsigned int *)t48) = t52;
    t53 = *((unsigned int *)t47);
    t54 = (t53 >> 15);
    t55 = (t54 & 1);
    *((unsigned int *)t43) = t55;
    t49 = ((char*)((ng2)));
    memset(t57, 0, 8);
    t56 = (t48 + 4);
    t58 = (t49 + 4);
    t60 = *((unsigned int *)t48);
    t61 = *((unsigned int *)t49);
    t62 = (t60 ^ t61);
    t63 = *((unsigned int *)t56);
    t64 = *((unsigned int *)t58);
    t65 = (t63 ^ t64);
    t66 = (t62 | t65);
    t67 = *((unsigned int *)t56);
    t68 = *((unsigned int *)t58);
    t69 = (t67 | t68);
    t70 = (~(t69));
    t71 = (t66 & t70);
    if (t71 != 0)
        goto LAB103;

LAB100:    if (t69 != 0)
        goto LAB102;

LAB101:    *((unsigned int *)t57) = 1;

LAB103:    memset(t73, 0, 8);
    t72 = (t57 + 4);
    t75 = *((unsigned int *)t72);
    t76 = (~(t75));
    t77 = *((unsigned int *)t57);
    t78 = (t77 & t76);
    t79 = (t78 & 1U);
    if (t79 != 0)
        goto LAB104;

LAB105:    if (*((unsigned int *)t72) != 0)
        goto LAB106;

LAB107:    t82 = *((unsigned int *)t41);
    t83 = *((unsigned int *)t73);
    t84 = (t82 & t83);
    *((unsigned int *)t81) = t84;
    t80 = (t41 + 4);
    t85 = (t73 + 4);
    t86 = (t81 + 4);
    t88 = *((unsigned int *)t80);
    t89 = *((unsigned int *)t85);
    t90 = (t88 | t89);
    *((unsigned int *)t86) = t90;
    t91 = *((unsigned int *)t86);
    t92 = (t91 != 0);
    if (t92 == 1)
        goto LAB108;

LAB109:
LAB110:    goto LAB99;

LAB102:    t59 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t59) = 1;
    goto LAB103;

LAB104:    *((unsigned int *)t73) = 1;
    goto LAB107;

LAB106:    t74 = (t73 + 4);
    *((unsigned int *)t73) = 1;
    *((unsigned int *)t74) = 1;
    goto LAB107;

LAB108:    t93 = *((unsigned int *)t81);
    t94 = *((unsigned int *)t86);
    *((unsigned int *)t81) = (t93 | t94);
    t87 = (t41 + 4);
    t95 = (t73 + 4);
    t97 = *((unsigned int *)t41);
    t98 = (~(t97));
    t99 = *((unsigned int *)t87);
    t100 = (~(t99));
    t101 = *((unsigned int *)t73);
    t102 = (~(t101));
    t103 = *((unsigned int *)t95);
    t104 = (~(t103));
    t6 = (t98 & t100);
    t31 = (t102 & t104);
    t105 = (~(t6));
    t106 = (~(t31));
    t107 = *((unsigned int *)t86);
    *((unsigned int *)t86) = (t107 & t105);
    t108 = *((unsigned int *)t86);
    *((unsigned int *)t86) = (t108 & t106);
    t109 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t109 & t105);
    t110 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t110 & t106);
    goto LAB110;

LAB111:    *((unsigned int *)t111) = 1;
    goto LAB114;

LAB113:    t112 = (t111 + 4);
    *((unsigned int *)t111) = 1;
    *((unsigned int *)t112) = 1;
    goto LAB114;

LAB115:    t119 = (t0 + 1048U);
    t123 = *((char **)t119);
    t119 = (t0 + 1208U);
    t124 = *((char **)t119);
    memset(t126, 0, 8);
    xsi_vlog_unsigned_add(t126, 16, t123, 16, t124, 16);
    t119 = ((char*)((ng9)));
    memset(t127, 0, 8);
    t125 = (t126 + 4);
    if (*((unsigned int *)t125) != 0)
        goto LAB119;

LAB118:    t128 = (t119 + 4);
    if (*((unsigned int *)t128) != 0)
        goto LAB119;

LAB122:    if (*((unsigned int *)t126) > *((unsigned int *)t119))
        goto LAB121;

LAB120:    *((unsigned int *)t127) = 1;

LAB121:    memset(t131, 0, 8);
    t130 = (t127 + 4);
    t133 = *((unsigned int *)t130);
    t134 = (~(t133));
    t135 = *((unsigned int *)t127);
    t136 = (t135 & t134);
    t137 = (t136 & 1U);
    if (t137 != 0)
        goto LAB123;

LAB124:    if (*((unsigned int *)t130) != 0)
        goto LAB125;

LAB126:    t140 = *((unsigned int *)t111);
    t141 = *((unsigned int *)t131);
    t142 = (t140 & t141);
    *((unsigned int *)t139) = t142;
    t138 = (t111 + 4);
    t143 = (t131 + 4);
    t144 = (t139 + 4);
    t146 = *((unsigned int *)t138);
    t147 = *((unsigned int *)t143);
    t148 = (t146 | t147);
    *((unsigned int *)t144) = t148;
    t149 = *((unsigned int *)t144);
    t150 = (t149 != 0);
    if (t150 == 1)
        goto LAB127;

LAB128:
LAB129:    goto LAB117;

LAB119:    t129 = (t127 + 4);
    *((unsigned int *)t127) = 1;
    *((unsigned int *)t129) = 1;
    goto LAB121;

LAB123:    *((unsigned int *)t131) = 1;
    goto LAB126;

LAB125:    t132 = (t131 + 4);
    *((unsigned int *)t131) = 1;
    *((unsigned int *)t132) = 1;
    goto LAB126;

LAB127:    t151 = *((unsigned int *)t139);
    t152 = *((unsigned int *)t144);
    *((unsigned int *)t139) = (t151 | t152);
    t145 = (t111 + 4);
    t153 = (t131 + 4);
    t155 = *((unsigned int *)t111);
    t156 = (~(t155));
    t157 = *((unsigned int *)t145);
    t158 = (~(t157));
    t159 = *((unsigned int *)t131);
    t160 = (~(t159));
    t161 = *((unsigned int *)t153);
    t162 = (~(t161));
    t32 = (t156 & t158);
    t163 = (t160 & t162);
    t165 = (~(t32));
    t166 = (~(t163));
    t167 = *((unsigned int *)t144);
    *((unsigned int *)t144) = (t167 & t165);
    t168 = *((unsigned int *)t144);
    *((unsigned int *)t144) = (t168 & t166);
    t169 = *((unsigned int *)t139);
    *((unsigned int *)t139) = (t169 & t165);
    t170 = *((unsigned int *)t139);
    *((unsigned int *)t139) = (t170 & t166);
    goto LAB129;

LAB130:    xsi_set_current_line(57, ng0);

LAB133:    xsi_set_current_line(58, ng0);
    t171 = ((char*)((ng8)));
    t177 = (t0 + 1768);
    xsi_vlogvar_assign_value(t177, t171, 0, 0, 16);
    goto LAB132;

LAB137:    t22 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t22) = 1;
    goto LAB138;

LAB139:    *((unsigned int *)t41) = 1;
    goto LAB142;

LAB141:    t42 = (t41 + 4);
    *((unsigned int *)t41) = 1;
    *((unsigned int *)t42) = 1;
    goto LAB142;

LAB143:    t46 = (t0 + 1208U);
    t47 = *((char **)t46);
    memset(t48, 0, 8);
    t46 = (t48 + 4);
    t49 = (t47 + 4);
    t50 = *((unsigned int *)t47);
    t51 = (t50 >> 15);
    t52 = (t51 & 1);
    *((unsigned int *)t48) = t52;
    t53 = *((unsigned int *)t49);
    t54 = (t53 >> 15);
    t55 = (t54 & 1);
    *((unsigned int *)t46) = t55;
    t56 = ((char*)((ng2)));
    memset(t57, 0, 8);
    t58 = (t48 + 4);
    t59 = (t56 + 4);
    t60 = *((unsigned int *)t48);
    t61 = *((unsigned int *)t56);
    t62 = (t60 ^ t61);
    t63 = *((unsigned int *)t58);
    t64 = *((unsigned int *)t59);
    t65 = (t63 ^ t64);
    t66 = (t62 | t65);
    t67 = *((unsigned int *)t58);
    t68 = *((unsigned int *)t59);
    t69 = (t67 | t68);
    t70 = (~(t69));
    t71 = (t66 & t70);
    if (t71 != 0)
        goto LAB149;

LAB146:    if (t69 != 0)
        goto LAB148;

LAB147:    *((unsigned int *)t57) = 1;

LAB149:    memset(t73, 0, 8);
    t74 = (t57 + 4);
    t75 = *((unsigned int *)t74);
    t76 = (~(t75));
    t77 = *((unsigned int *)t57);
    t78 = (t77 & t76);
    t79 = (t78 & 1U);
    if (t79 != 0)
        goto LAB150;

LAB151:    if (*((unsigned int *)t74) != 0)
        goto LAB152;

LAB153:    t82 = *((unsigned int *)t41);
    t83 = *((unsigned int *)t73);
    t84 = (t82 & t83);
    *((unsigned int *)t81) = t84;
    t85 = (t41 + 4);
    t86 = (t73 + 4);
    t87 = (t81 + 4);
    t88 = *((unsigned int *)t85);
    t89 = *((unsigned int *)t86);
    t90 = (t88 | t89);
    *((unsigned int *)t87) = t90;
    t91 = *((unsigned int *)t87);
    t92 = (t91 != 0);
    if (t92 == 1)
        goto LAB154;

LAB155:
LAB156:    goto LAB145;

LAB148:    t72 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t72) = 1;
    goto LAB149;

LAB150:    *((unsigned int *)t73) = 1;
    goto LAB153;

LAB152:    t80 = (t73 + 4);
    *((unsigned int *)t73) = 1;
    *((unsigned int *)t80) = 1;
    goto LAB153;

LAB154:    t93 = *((unsigned int *)t81);
    t94 = *((unsigned int *)t87);
    *((unsigned int *)t81) = (t93 | t94);
    t95 = (t41 + 4);
    t96 = (t73 + 4);
    t97 = *((unsigned int *)t41);
    t98 = (~(t97));
    t99 = *((unsigned int *)t95);
    t100 = (~(t99));
    t101 = *((unsigned int *)t73);
    t102 = (~(t101));
    t103 = *((unsigned int *)t96);
    t104 = (~(t103));
    t31 = (t98 & t100);
    t32 = (t102 & t104);
    t105 = (~(t31));
    t106 = (~(t32));
    t107 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t107 & t105);
    t108 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t108 & t106);
    t109 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t109 & t105);
    t110 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t110 & t106);
    goto LAB156;

LAB157:    *((unsigned int *)t111) = 1;
    goto LAB160;

LAB159:    t118 = (t111 + 4);
    *((unsigned int *)t111) = 1;
    *((unsigned int *)t118) = 1;
    goto LAB160;

LAB161:    t123 = (t0 + 1048U);
    t124 = *((char **)t123);
    t123 = (t0 + 1208U);
    t125 = *((char **)t123);
    memset(t126, 0, 8);
    xsi_vlog_unsigned_add(t126, 16, t124, 16, t125, 16);
    t123 = ((char*)((ng8)));
    memset(t127, 0, 8);
    t128 = (t126 + 4);
    if (*((unsigned int *)t128) != 0)
        goto LAB165;

LAB164:    t129 = (t123 + 4);
    if (*((unsigned int *)t129) != 0)
        goto LAB165;

LAB168:    if (*((unsigned int *)t126) < *((unsigned int *)t123))
        goto LAB167;

LAB166:    *((unsigned int *)t127) = 1;

LAB167:    memset(t131, 0, 8);
    t132 = (t127 + 4);
    t133 = *((unsigned int *)t132);
    t134 = (~(t133));
    t135 = *((unsigned int *)t127);
    t136 = (t135 & t134);
    t137 = (t136 & 1U);
    if (t137 != 0)
        goto LAB169;

LAB170:    if (*((unsigned int *)t132) != 0)
        goto LAB171;

LAB172:    t140 = *((unsigned int *)t111);
    t141 = *((unsigned int *)t131);
    t142 = (t140 & t141);
    *((unsigned int *)t139) = t142;
    t143 = (t111 + 4);
    t144 = (t131 + 4);
    t145 = (t139 + 4);
    t146 = *((unsigned int *)t143);
    t147 = *((unsigned int *)t144);
    t148 = (t146 | t147);
    *((unsigned int *)t145) = t148;
    t149 = *((unsigned int *)t145);
    t150 = (t149 != 0);
    if (t150 == 1)
        goto LAB173;

LAB174:
LAB175:    goto LAB163;

LAB165:    t130 = (t127 + 4);
    *((unsigned int *)t127) = 1;
    *((unsigned int *)t130) = 1;
    goto LAB167;

LAB169:    *((unsigned int *)t131) = 1;
    goto LAB172;

LAB171:    t138 = (t131 + 4);
    *((unsigned int *)t131) = 1;
    *((unsigned int *)t138) = 1;
    goto LAB172;

LAB173:    t151 = *((unsigned int *)t139);
    t152 = *((unsigned int *)t145);
    *((unsigned int *)t139) = (t151 | t152);
    t153 = (t111 + 4);
    t154 = (t131 + 4);
    t155 = *((unsigned int *)t111);
    t156 = (~(t155));
    t157 = *((unsigned int *)t153);
    t158 = (~(t157));
    t159 = *((unsigned int *)t131);
    t160 = (~(t159));
    t161 = *((unsigned int *)t154);
    t162 = (~(t161));
    t163 = (t156 & t158);
    t164 = (t160 & t162);
    t165 = (~(t163));
    t166 = (~(t164));
    t167 = *((unsigned int *)t145);
    *((unsigned int *)t145) = (t167 & t165);
    t168 = *((unsigned int *)t145);
    *((unsigned int *)t145) = (t168 & t166);
    t169 = *((unsigned int *)t139);
    *((unsigned int *)t139) = (t169 & t165);
    t170 = *((unsigned int *)t139);
    *((unsigned int *)t139) = (t170 & t166);
    goto LAB175;

LAB176:    xsi_set_current_line(67, ng0);
    t177 = ((char*)((ng9)));
    t178 = (t0 + 1768);
    xsi_vlogvar_assign_value(t178, t177, 0, 0, 16);
    goto LAB178;

LAB181:    t21 = (t40 + 4);
    *((unsigned int *)t40) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB182;

LAB183:    *((unsigned int *)t41) = 1;
    goto LAB186;

LAB185:    t39 = (t41 + 4);
    *((unsigned int *)t41) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB186;

LAB187:    t43 = (t0 + 1208U);
    t46 = *((char **)t43);
    memset(t48, 0, 8);
    t43 = (t48 + 4);
    t47 = (t46 + 4);
    t50 = *((unsigned int *)t46);
    t51 = (t50 >> 15);
    t52 = (t51 & 1);
    *((unsigned int *)t48) = t52;
    t53 = *((unsigned int *)t47);
    t54 = (t53 >> 15);
    t55 = (t54 & 1);
    *((unsigned int *)t43) = t55;
    t49 = ((char*)((ng1)));
    memset(t57, 0, 8);
    t56 = (t48 + 4);
    t58 = (t49 + 4);
    t60 = *((unsigned int *)t48);
    t61 = *((unsigned int *)t49);
    t62 = (t60 ^ t61);
    t63 = *((unsigned int *)t56);
    t64 = *((unsigned int *)t58);
    t65 = (t63 ^ t64);
    t66 = (t62 | t65);
    t67 = *((unsigned int *)t56);
    t68 = *((unsigned int *)t58);
    t69 = (t67 | t68);
    t70 = (~(t69));
    t71 = (t66 & t70);
    if (t71 != 0)
        goto LAB193;

LAB190:    if (t69 != 0)
        goto LAB192;

LAB191:    *((unsigned int *)t57) = 1;

LAB193:    memset(t73, 0, 8);
    t72 = (t57 + 4);
    t75 = *((unsigned int *)t72);
    t76 = (~(t75));
    t77 = *((unsigned int *)t57);
    t78 = (t77 & t76);
    t79 = (t78 & 1U);
    if (t79 != 0)
        goto LAB194;

LAB195:    if (*((unsigned int *)t72) != 0)
        goto LAB196;

LAB197:    t82 = *((unsigned int *)t41);
    t83 = *((unsigned int *)t73);
    t84 = (t82 & t83);
    *((unsigned int *)t81) = t84;
    t80 = (t41 + 4);
    t85 = (t73 + 4);
    t86 = (t81 + 4);
    t88 = *((unsigned int *)t80);
    t89 = *((unsigned int *)t85);
    t90 = (t88 | t89);
    *((unsigned int *)t86) = t90;
    t91 = *((unsigned int *)t86);
    t92 = (t91 != 0);
    if (t92 == 1)
        goto LAB198;

LAB199:
LAB200:    goto LAB189;

LAB192:    t59 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t59) = 1;
    goto LAB193;

LAB194:    *((unsigned int *)t73) = 1;
    goto LAB197;

LAB196:    t74 = (t73 + 4);
    *((unsigned int *)t73) = 1;
    *((unsigned int *)t74) = 1;
    goto LAB197;

LAB198:    t93 = *((unsigned int *)t81);
    t94 = *((unsigned int *)t86);
    *((unsigned int *)t81) = (t93 | t94);
    t87 = (t41 + 4);
    t95 = (t73 + 4);
    t97 = *((unsigned int *)t41);
    t98 = (~(t97));
    t99 = *((unsigned int *)t87);
    t100 = (~(t99));
    t101 = *((unsigned int *)t73);
    t102 = (~(t101));
    t103 = *((unsigned int *)t95);
    t104 = (~(t103));
    t6 = (t98 & t100);
    t31 = (t102 & t104);
    t105 = (~(t6));
    t106 = (~(t31));
    t107 = *((unsigned int *)t86);
    *((unsigned int *)t86) = (t107 & t105);
    t108 = *((unsigned int *)t86);
    *((unsigned int *)t86) = (t108 & t106);
    t109 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t109 & t105);
    t110 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t110 & t106);
    goto LAB200;

LAB201:    *((unsigned int *)t111) = 1;
    goto LAB204;

LAB203:    t112 = (t111 + 4);
    *((unsigned int *)t111) = 1;
    *((unsigned int *)t112) = 1;
    goto LAB204;

LAB205:    t119 = (t0 + 1048U);
    t123 = *((char **)t119);
    t119 = (t0 + 1208U);
    t124 = *((char **)t119);
    memset(t126, 0, 8);
    xsi_vlog_unsigned_add(t126, 16, t123, 16, t124, 16);
    t119 = ((char*)((ng9)));
    memset(t127, 0, 8);
    t125 = (t126 + 4);
    if (*((unsigned int *)t125) != 0)
        goto LAB209;

LAB208:    t128 = (t119 + 4);
    if (*((unsigned int *)t128) != 0)
        goto LAB209;

LAB212:    if (*((unsigned int *)t126) > *((unsigned int *)t119))
        goto LAB211;

LAB210:    *((unsigned int *)t127) = 1;

LAB211:    memset(t131, 0, 8);
    t130 = (t127 + 4);
    t133 = *((unsigned int *)t130);
    t134 = (~(t133));
    t135 = *((unsigned int *)t127);
    t136 = (t135 & t134);
    t137 = (t136 & 1U);
    if (t137 != 0)
        goto LAB213;

LAB214:    if (*((unsigned int *)t130) != 0)
        goto LAB215;

LAB216:    t140 = *((unsigned int *)t111);
    t141 = *((unsigned int *)t131);
    t142 = (t140 & t141);
    *((unsigned int *)t139) = t142;
    t138 = (t111 + 4);
    t143 = (t131 + 4);
    t144 = (t139 + 4);
    t146 = *((unsigned int *)t138);
    t147 = *((unsigned int *)t143);
    t148 = (t146 | t147);
    *((unsigned int *)t144) = t148;
    t149 = *((unsigned int *)t144);
    t150 = (t149 != 0);
    if (t150 == 1)
        goto LAB217;

LAB218:
LAB219:    goto LAB207;

LAB209:    t129 = (t127 + 4);
    *((unsigned int *)t127) = 1;
    *((unsigned int *)t129) = 1;
    goto LAB211;

LAB213:    *((unsigned int *)t131) = 1;
    goto LAB216;

LAB215:    t132 = (t131 + 4);
    *((unsigned int *)t131) = 1;
    *((unsigned int *)t132) = 1;
    goto LAB216;

LAB217:    t151 = *((unsigned int *)t139);
    t152 = *((unsigned int *)t144);
    *((unsigned int *)t139) = (t151 | t152);
    t145 = (t111 + 4);
    t153 = (t131 + 4);
    t155 = *((unsigned int *)t111);
    t156 = (~(t155));
    t157 = *((unsigned int *)t145);
    t158 = (~(t157));
    t159 = *((unsigned int *)t131);
    t160 = (~(t159));
    t161 = *((unsigned int *)t153);
    t162 = (~(t161));
    t32 = (t156 & t158);
    t163 = (t160 & t162);
    t165 = (~(t32));
    t166 = (~(t163));
    t167 = *((unsigned int *)t144);
    *((unsigned int *)t144) = (t167 & t165);
    t168 = *((unsigned int *)t144);
    *((unsigned int *)t144) = (t168 & t166);
    t169 = *((unsigned int *)t139);
    *((unsigned int *)t139) = (t169 & t165);
    t170 = *((unsigned int *)t139);
    *((unsigned int *)t139) = (t170 & t166);
    goto LAB219;

LAB220:    xsi_set_current_line(69, ng0);
    t171 = ((char*)((ng8)));
    t177 = (t0 + 1768);
    xsi_vlogvar_assign_value(t177, t171, 0, 0, 16);
    goto LAB222;

LAB225:    xsi_set_current_line(79, ng0);

LAB234:    xsi_set_current_line(80, ng0);
    t39 = (t0 + 1208U);
    t42 = *((char **)t39);
    t39 = ((char*)((ng1)));
    xsi_vlogtype_concat(t48, 32, 32, 2U, t39, 16, t42, 16);
    t43 = (t0 + 2088);
    xsi_vlogvar_assign_value(t43, t48, 0, 0, 32);
    xsi_set_current_line(81, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = (t0 + 2248);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 16);
    xsi_set_current_line(82, ng0);
    t2 = ((char*)((ng12)));
    t3 = (t2 + 4);
    t11 = *((unsigned int *)t3);
    t12 = (~(t11));
    t13 = *((unsigned int *)t2);
    t6 = (t13 & t12);
    t4 = (t0 + 5420);
    *((int *)t4) = t6;

LAB235:    t7 = (t0 + 5420);
    if (*((int *)t7) > 0)
        goto LAB236;

LAB237:    xsi_set_current_line(94, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t40, 0, 8);
    t7 = (t40 + 4);
    t8 = (t4 + 4);
    t11 = *((unsigned int *)t4);
    t12 = (t11 >> 0);
    *((unsigned int *)t40) = t12;
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 0);
    *((unsigned int *)t7) = t14;
    t15 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t15 & 4294967295U);
    t16 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t16 & 4294967295U);
    t9 = (t0 + 1928);
    xsi_vlogvar_assign_value(t9, t40, 0, 0, 32);
    goto LAB233;

LAB227:    xsi_set_current_line(98, ng0);

LAB250:    xsi_set_current_line(100, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    memset(t41, 0, 8);
    t3 = (t41 + 4);
    t7 = (t4 + 4);
    t11 = *((unsigned int *)t4);
    t12 = (~(t11));
    *((unsigned int *)t41) = t12;
    *((unsigned int *)t3) = 0;
    if (*((unsigned int *)t7) != 0)
        goto LAB252;

LAB251:    t17 = *((unsigned int *)t41);
    *((unsigned int *)t41) = (t17 & 65535U);
    t18 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t18 & 65535U);
    t8 = ((char*)((ng2)));
    memset(t48, 0, 8);
    xsi_vlog_unsigned_add(t48, 16, t41, 16, t8, 16);
    t9 = ((char*)((ng1)));
    xsi_vlogtype_concat(t40, 32, 32, 2U, t9, 16, t48, 16);
    t21 = (t0 + 2088);
    xsi_vlogvar_assign_value(t21, t40, 0, 0, 32);
    xsi_set_current_line(101, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = (t0 + 2248);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 16);
    xsi_set_current_line(102, ng0);
    t2 = ((char*)((ng12)));
    t3 = (t2 + 4);
    t11 = *((unsigned int *)t3);
    t12 = (~(t11));
    t13 = *((unsigned int *)t2);
    t6 = (t13 & t12);
    t4 = (t0 + 5424);
    *((int *)t4) = t6;

LAB253:    t7 = (t0 + 5424);
    if (*((int *)t7) > 0)
        goto LAB254;

LAB255:    xsi_set_current_line(115, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t40, 0, 8);
    xsi_vlog_unsigned_unary_minus(t40, 32, t4, 32);
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t40, 0, 0, 32);
    xsi_set_current_line(116, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t40, 0, 8);
    t7 = (t40 + 4);
    t8 = (t4 + 4);
    t11 = *((unsigned int *)t4);
    t12 = (t11 >> 0);
    *((unsigned int *)t40) = t12;
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 0);
    *((unsigned int *)t7) = t14;
    t15 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t15 & 4294967295U);
    t16 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t16 & 4294967295U);
    t9 = (t0 + 1928);
    xsi_vlogvar_assign_value(t9, t40, 0, 0, 32);
    goto LAB233;

LAB229:    xsi_set_current_line(120, ng0);

LAB268:    xsi_set_current_line(121, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    t3 = ((char*)((ng1)));
    xsi_vlogtype_concat(t40, 32, 32, 2U, t3, 16, t4, 16);
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t40, 0, 0, 32);
    xsi_set_current_line(122, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    memset(t40, 0, 8);
    t2 = (t40 + 4);
    t4 = (t3 + 4);
    t11 = *((unsigned int *)t3);
    t12 = (~(t11));
    *((unsigned int *)t40) = t12;
    *((unsigned int *)t2) = 0;
    if (*((unsigned int *)t4) != 0)
        goto LAB270;

LAB269:    t17 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t17 & 65535U);
    t18 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t18 & 65535U);
    t7 = ((char*)((ng2)));
    memset(t41, 0, 8);
    xsi_vlog_unsigned_add(t41, 16, t40, 16, t7, 16);
    t8 = (t0 + 2248);
    xsi_vlogvar_assign_value(t8, t41, 0, 0, 16);
    xsi_set_current_line(123, ng0);
    t2 = ((char*)((ng12)));
    t3 = (t2 + 4);
    t11 = *((unsigned int *)t3);
    t12 = (~(t11));
    t13 = *((unsigned int *)t2);
    t6 = (t13 & t12);
    t4 = (t0 + 5428);
    *((int *)t4) = t6;

LAB271:    t7 = (t0 + 5428);
    if (*((int *)t7) > 0)
        goto LAB272;

LAB273:    xsi_set_current_line(136, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t40, 0, 8);
    xsi_vlog_unsigned_unary_minus(t40, 32, t4, 32);
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t40, 0, 0, 32);
    xsi_set_current_line(137, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t40, 0, 8);
    t7 = (t40 + 4);
    t8 = (t4 + 4);
    t11 = *((unsigned int *)t4);
    t12 = (t11 >> 0);
    *((unsigned int *)t40) = t12;
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 0);
    *((unsigned int *)t7) = t14;
    t15 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t15 & 4294967295U);
    t16 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t16 & 4294967295U);
    t9 = (t0 + 1928);
    xsi_vlogvar_assign_value(t9, t40, 0, 0, 32);
    goto LAB233;

LAB231:    xsi_set_current_line(141, ng0);

LAB286:    xsi_set_current_line(142, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    memset(t41, 0, 8);
    xsi_vlog_unsigned_unary_minus(t41, 16, t4, 16);
    t3 = ((char*)((ng1)));
    xsi_vlogtype_concat(t40, 32, 32, 2U, t3, 16, t41, 16);
    t7 = (t0 + 2088);
    xsi_vlogvar_assign_value(t7, t40, 0, 0, 32);
    xsi_set_current_line(143, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    memset(t40, 0, 8);
    xsi_vlog_unsigned_unary_minus(t40, 16, t3, 16);
    t2 = (t0 + 2248);
    xsi_vlogvar_assign_value(t2, t40, 0, 0, 16);
    xsi_set_current_line(144, ng0);
    t2 = ((char*)((ng12)));
    t3 = (t2 + 4);
    t11 = *((unsigned int *)t3);
    t12 = (~(t11));
    t13 = *((unsigned int *)t2);
    t6 = (t13 & t12);
    t4 = (t0 + 5432);
    *((int *)t4) = t6;

LAB287:    t7 = (t0 + 5432);
    if (*((int *)t7) > 0)
        goto LAB288;

LAB289:    xsi_set_current_line(157, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t40, 0, 8);
    t7 = (t40 + 4);
    t8 = (t4 + 4);
    t11 = *((unsigned int *)t4);
    t12 = (t11 >> 0);
    *((unsigned int *)t40) = t12;
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 0);
    *((unsigned int *)t7) = t14;
    t15 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t15 & 4294967295U);
    t16 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t16 & 4294967295U);
    t9 = (t0 + 1928);
    xsi_vlogvar_assign_value(t9, t40, 0, 0, 32);
    goto LAB233;

LAB236:    xsi_set_current_line(83, ng0);

LAB238:    xsi_set_current_line(84, ng0);
    t8 = (t0 + 2088);
    t9 = (t8 + 56U);
    t21 = *((char **)t9);
    memset(t40, 0, 8);
    t22 = (t40 + 4);
    t39 = (t21 + 4);
    t14 = *((unsigned int *)t21);
    t15 = (t14 >> 0);
    t16 = (t15 & 1);
    *((unsigned int *)t40) = t16;
    t17 = *((unsigned int *)t39);
    t18 = (t17 >> 0);
    t19 = (t18 & 1);
    *((unsigned int *)t22) = t19;
    t42 = ((char*)((ng2)));
    memset(t41, 0, 8);
    t43 = (t40 + 4);
    t46 = (t42 + 4);
    t20 = *((unsigned int *)t40);
    t23 = *((unsigned int *)t42);
    t24 = (t20 ^ t23);
    t25 = *((unsigned int *)t43);
    t26 = *((unsigned int *)t46);
    t27 = (t25 ^ t26);
    t28 = (t24 | t27);
    t29 = *((unsigned int *)t43);
    t30 = *((unsigned int *)t46);
    t33 = (t29 | t30);
    t34 = (~(t33));
    t35 = (t28 & t34);
    if (t35 != 0)
        goto LAB242;

LAB239:    if (t33 != 0)
        goto LAB241;

LAB240:    *((unsigned int *)t41) = 1;

LAB242:    t49 = (t41 + 4);
    t36 = *((unsigned int *)t49);
    t37 = (~(t36));
    t38 = *((unsigned int *)t41);
    t44 = (t38 & t37);
    t45 = (t44 != 0);
    if (t45 > 0)
        goto LAB243;

LAB244:    xsi_set_current_line(90, ng0);

LAB249:    xsi_set_current_line(91, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng14)));
    memset(t40, 0, 8);
    xsi_vlog_unsigned_rshift(t40, 32, t4, 32, t7, 32);
    t8 = (t0 + 2088);
    xsi_vlogvar_assign_value(t8, t40, 0, 0, 32);

LAB245:    t2 = (t0 + 5420);
    t6 = *((int *)t2);
    *((int *)t2) = (t6 - 1);
    goto LAB235;

LAB241:    t47 = (t41 + 4);
    *((unsigned int *)t41) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB242;

LAB243:    xsi_set_current_line(85, ng0);

LAB246:    xsi_set_current_line(86, ng0);
    t56 = (t0 + 2088);
    t58 = (t56 + 56U);
    t59 = *((char **)t58);
    memset(t48, 0, 8);
    t72 = (t48 + 4);
    t74 = (t59 + 4);
    t50 = *((unsigned int *)t59);
    t51 = (t50 >> 16);
    *((unsigned int *)t48) = t51;
    t52 = *((unsigned int *)t74);
    t53 = (t52 >> 16);
    *((unsigned int *)t72) = t53;
    t54 = *((unsigned int *)t48);
    *((unsigned int *)t48) = (t54 & 65535U);
    t55 = *((unsigned int *)t72);
    *((unsigned int *)t72) = (t55 & 65535U);
    t80 = (t0 + 2248);
    t85 = (t80 + 56U);
    t86 = *((char **)t85);
    memset(t57, 0, 8);
    xsi_vlog_unsigned_add(t57, 16, t48, 16, t86, 16);
    t87 = (t0 + 2088);
    t95 = (t0 + 2088);
    t96 = (t95 + 72U);
    t112 = *((char **)t96);
    t118 = ((char*)((ng13)));
    t119 = ((char*)((ng12)));
    xsi_vlog_convert_partindices(t73, t81, t111, ((int*)(t112)), 2, t118, 32, 1, t119, 32, 1);
    t123 = (t73 + 4);
    t60 = *((unsigned int *)t123);
    t31 = (!(t60));
    t124 = (t81 + 4);
    t61 = *((unsigned int *)t124);
    t32 = (!(t61));
    t163 = (t31 && t32);
    t125 = (t111 + 4);
    t62 = *((unsigned int *)t125);
    t164 = (!(t62));
    t179 = (t163 && t164);
    if (t179 == 1)
        goto LAB247;

LAB248:    xsi_set_current_line(87, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng14)));
    memset(t40, 0, 8);
    xsi_vlog_unsigned_rshift(t40, 32, t4, 32, t7, 32);
    t8 = (t0 + 2088);
    xsi_vlogvar_assign_value(t8, t40, 0, 0, 32);
    goto LAB245;

LAB247:    t63 = *((unsigned int *)t111);
    t180 = (t63 + 0);
    t64 = *((unsigned int *)t73);
    t65 = *((unsigned int *)t81);
    t181 = (t64 - t65);
    t182 = (t181 + 1);
    xsi_vlogvar_assign_value(t87, t57, t180, *((unsigned int *)t81), t182);
    goto LAB248;

LAB252:    t13 = *((unsigned int *)t41);
    t14 = *((unsigned int *)t7);
    *((unsigned int *)t41) = (t13 | t14);
    t15 = *((unsigned int *)t3);
    t16 = *((unsigned int *)t7);
    *((unsigned int *)t3) = (t15 | t16);
    goto LAB251;

LAB254:    xsi_set_current_line(103, ng0);

LAB256:    xsi_set_current_line(104, ng0);
    t8 = (t0 + 2088);
    t9 = (t8 + 56U);
    t21 = *((char **)t9);
    memset(t40, 0, 8);
    t22 = (t40 + 4);
    t39 = (t21 + 4);
    t14 = *((unsigned int *)t21);
    t15 = (t14 >> 0);
    t16 = (t15 & 1);
    *((unsigned int *)t40) = t16;
    t17 = *((unsigned int *)t39);
    t18 = (t17 >> 0);
    t19 = (t18 & 1);
    *((unsigned int *)t22) = t19;
    t42 = ((char*)((ng2)));
    memset(t41, 0, 8);
    t43 = (t40 + 4);
    t46 = (t42 + 4);
    t20 = *((unsigned int *)t40);
    t23 = *((unsigned int *)t42);
    t24 = (t20 ^ t23);
    t25 = *((unsigned int *)t43);
    t26 = *((unsigned int *)t46);
    t27 = (t25 ^ t26);
    t28 = (t24 | t27);
    t29 = *((unsigned int *)t43);
    t30 = *((unsigned int *)t46);
    t33 = (t29 | t30);
    t34 = (~(t33));
    t35 = (t28 & t34);
    if (t35 != 0)
        goto LAB260;

LAB257:    if (t33 != 0)
        goto LAB259;

LAB258:    *((unsigned int *)t41) = 1;

LAB260:    t49 = (t41 + 4);
    t36 = *((unsigned int *)t49);
    t37 = (~(t36));
    t38 = *((unsigned int *)t41);
    t44 = (t38 & t37);
    t45 = (t44 != 0);
    if (t45 > 0)
        goto LAB261;

LAB262:    xsi_set_current_line(110, ng0);

LAB267:    xsi_set_current_line(111, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng14)));
    memset(t40, 0, 8);
    xsi_vlog_unsigned_rshift(t40, 32, t4, 32, t7, 32);
    t8 = (t0 + 2088);
    xsi_vlogvar_assign_value(t8, t40, 0, 0, 32);

LAB263:    t2 = (t0 + 5424);
    t6 = *((int *)t2);
    *((int *)t2) = (t6 - 1);
    goto LAB253;

LAB259:    t47 = (t41 + 4);
    *((unsigned int *)t41) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB260;

LAB261:    xsi_set_current_line(105, ng0);

LAB264:    xsi_set_current_line(106, ng0);
    t56 = (t0 + 2088);
    t58 = (t56 + 56U);
    t59 = *((char **)t58);
    memset(t48, 0, 8);
    t72 = (t48 + 4);
    t74 = (t59 + 4);
    t50 = *((unsigned int *)t59);
    t51 = (t50 >> 16);
    *((unsigned int *)t48) = t51;
    t52 = *((unsigned int *)t74);
    t53 = (t52 >> 16);
    *((unsigned int *)t72) = t53;
    t54 = *((unsigned int *)t48);
    *((unsigned int *)t48) = (t54 & 65535U);
    t55 = *((unsigned int *)t72);
    *((unsigned int *)t72) = (t55 & 65535U);
    t80 = (t0 + 2248);
    t85 = (t80 + 56U);
    t86 = *((char **)t85);
    memset(t57, 0, 8);
    xsi_vlog_unsigned_add(t57, 16, t48, 16, t86, 16);
    t87 = (t0 + 2088);
    t95 = (t0 + 2088);
    t96 = (t95 + 72U);
    t112 = *((char **)t96);
    t118 = ((char*)((ng13)));
    t119 = ((char*)((ng12)));
    xsi_vlog_convert_partindices(t73, t81, t111, ((int*)(t112)), 2, t118, 32, 1, t119, 32, 1);
    t123 = (t73 + 4);
    t60 = *((unsigned int *)t123);
    t31 = (!(t60));
    t124 = (t81 + 4);
    t61 = *((unsigned int *)t124);
    t32 = (!(t61));
    t163 = (t31 && t32);
    t125 = (t111 + 4);
    t62 = *((unsigned int *)t125);
    t164 = (!(t62));
    t179 = (t163 && t164);
    if (t179 == 1)
        goto LAB265;

LAB266:    xsi_set_current_line(107, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng14)));
    memset(t40, 0, 8);
    xsi_vlog_unsigned_rshift(t40, 32, t4, 32, t7, 32);
    t8 = (t0 + 2088);
    xsi_vlogvar_assign_value(t8, t40, 0, 0, 32);
    goto LAB263;

LAB265:    t63 = *((unsigned int *)t111);
    t180 = (t63 + 0);
    t64 = *((unsigned int *)t73);
    t65 = *((unsigned int *)t81);
    t181 = (t64 - t65);
    t182 = (t181 + 1);
    xsi_vlogvar_assign_value(t87, t57, t180, *((unsigned int *)t81), t182);
    goto LAB266;

LAB270:    t13 = *((unsigned int *)t40);
    t14 = *((unsigned int *)t4);
    *((unsigned int *)t40) = (t13 | t14);
    t15 = *((unsigned int *)t2);
    t16 = *((unsigned int *)t4);
    *((unsigned int *)t2) = (t15 | t16);
    goto LAB269;

LAB272:    xsi_set_current_line(125, ng0);

LAB274:    xsi_set_current_line(126, ng0);
    t8 = (t0 + 2088);
    t9 = (t8 + 56U);
    t21 = *((char **)t9);
    memset(t40, 0, 8);
    t22 = (t40 + 4);
    t39 = (t21 + 4);
    t14 = *((unsigned int *)t21);
    t15 = (t14 >> 0);
    t16 = (t15 & 1);
    *((unsigned int *)t40) = t16;
    t17 = *((unsigned int *)t39);
    t18 = (t17 >> 0);
    t19 = (t18 & 1);
    *((unsigned int *)t22) = t19;
    t42 = ((char*)((ng2)));
    memset(t41, 0, 8);
    t43 = (t40 + 4);
    t46 = (t42 + 4);
    t20 = *((unsigned int *)t40);
    t23 = *((unsigned int *)t42);
    t24 = (t20 ^ t23);
    t25 = *((unsigned int *)t43);
    t26 = *((unsigned int *)t46);
    t27 = (t25 ^ t26);
    t28 = (t24 | t27);
    t29 = *((unsigned int *)t43);
    t30 = *((unsigned int *)t46);
    t33 = (t29 | t30);
    t34 = (~(t33));
    t35 = (t28 & t34);
    if (t35 != 0)
        goto LAB278;

LAB275:    if (t33 != 0)
        goto LAB277;

LAB276:    *((unsigned int *)t41) = 1;

LAB278:    t49 = (t41 + 4);
    t36 = *((unsigned int *)t49);
    t37 = (~(t36));
    t38 = *((unsigned int *)t41);
    t44 = (t38 & t37);
    t45 = (t44 != 0);
    if (t45 > 0)
        goto LAB279;

LAB280:    xsi_set_current_line(132, ng0);

LAB285:    xsi_set_current_line(133, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng14)));
    memset(t40, 0, 8);
    xsi_vlog_unsigned_rshift(t40, 32, t4, 32, t7, 32);
    t8 = (t0 + 2088);
    xsi_vlogvar_assign_value(t8, t40, 0, 0, 32);

LAB281:    t2 = (t0 + 5428);
    t6 = *((int *)t2);
    *((int *)t2) = (t6 - 1);
    goto LAB271;

LAB277:    t47 = (t41 + 4);
    *((unsigned int *)t41) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB278;

LAB279:    xsi_set_current_line(127, ng0);

LAB282:    xsi_set_current_line(128, ng0);
    t56 = (t0 + 2088);
    t58 = (t56 + 56U);
    t59 = *((char **)t58);
    memset(t48, 0, 8);
    t72 = (t48 + 4);
    t74 = (t59 + 4);
    t50 = *((unsigned int *)t59);
    t51 = (t50 >> 16);
    *((unsigned int *)t48) = t51;
    t52 = *((unsigned int *)t74);
    t53 = (t52 >> 16);
    *((unsigned int *)t72) = t53;
    t54 = *((unsigned int *)t48);
    *((unsigned int *)t48) = (t54 & 65535U);
    t55 = *((unsigned int *)t72);
    *((unsigned int *)t72) = (t55 & 65535U);
    t80 = (t0 + 2248);
    t85 = (t80 + 56U);
    t86 = *((char **)t85);
    memset(t57, 0, 8);
    xsi_vlog_unsigned_add(t57, 16, t48, 16, t86, 16);
    t87 = (t0 + 2088);
    t95 = (t0 + 2088);
    t96 = (t95 + 72U);
    t112 = *((char **)t96);
    t118 = ((char*)((ng13)));
    t119 = ((char*)((ng12)));
    xsi_vlog_convert_partindices(t73, t81, t111, ((int*)(t112)), 2, t118, 32, 1, t119, 32, 1);
    t123 = (t73 + 4);
    t60 = *((unsigned int *)t123);
    t31 = (!(t60));
    t124 = (t81 + 4);
    t61 = *((unsigned int *)t124);
    t32 = (!(t61));
    t163 = (t31 && t32);
    t125 = (t111 + 4);
    t62 = *((unsigned int *)t125);
    t164 = (!(t62));
    t179 = (t163 && t164);
    if (t179 == 1)
        goto LAB283;

LAB284:    xsi_set_current_line(129, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng14)));
    memset(t40, 0, 8);
    xsi_vlog_unsigned_rshift(t40, 32, t4, 32, t7, 32);
    t8 = (t0 + 2088);
    xsi_vlogvar_assign_value(t8, t40, 0, 0, 32);
    goto LAB281;

LAB283:    t63 = *((unsigned int *)t111);
    t180 = (t63 + 0);
    t64 = *((unsigned int *)t73);
    t65 = *((unsigned int *)t81);
    t181 = (t64 - t65);
    t182 = (t181 + 1);
    xsi_vlogvar_assign_value(t87, t57, t180, *((unsigned int *)t81), t182);
    goto LAB284;

LAB288:    xsi_set_current_line(145, ng0);

LAB290:    xsi_set_current_line(146, ng0);
    t8 = (t0 + 2088);
    t9 = (t8 + 56U);
    t21 = *((char **)t9);
    memset(t40, 0, 8);
    t22 = (t40 + 4);
    t39 = (t21 + 4);
    t14 = *((unsigned int *)t21);
    t15 = (t14 >> 0);
    t16 = (t15 & 1);
    *((unsigned int *)t40) = t16;
    t17 = *((unsigned int *)t39);
    t18 = (t17 >> 0);
    t19 = (t18 & 1);
    *((unsigned int *)t22) = t19;
    t42 = ((char*)((ng2)));
    memset(t41, 0, 8);
    t43 = (t40 + 4);
    t46 = (t42 + 4);
    t20 = *((unsigned int *)t40);
    t23 = *((unsigned int *)t42);
    t24 = (t20 ^ t23);
    t25 = *((unsigned int *)t43);
    t26 = *((unsigned int *)t46);
    t27 = (t25 ^ t26);
    t28 = (t24 | t27);
    t29 = *((unsigned int *)t43);
    t30 = *((unsigned int *)t46);
    t33 = (t29 | t30);
    t34 = (~(t33));
    t35 = (t28 & t34);
    if (t35 != 0)
        goto LAB294;

LAB291:    if (t33 != 0)
        goto LAB293;

LAB292:    *((unsigned int *)t41) = 1;

LAB294:    t49 = (t41 + 4);
    t36 = *((unsigned int *)t49);
    t37 = (~(t36));
    t38 = *((unsigned int *)t41);
    t44 = (t38 & t37);
    t45 = (t44 != 0);
    if (t45 > 0)
        goto LAB295;

LAB296:    xsi_set_current_line(152, ng0);

LAB301:    xsi_set_current_line(153, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng14)));
    memset(t40, 0, 8);
    xsi_vlog_unsigned_rshift(t40, 32, t4, 32, t7, 32);
    t8 = (t0 + 2088);
    xsi_vlogvar_assign_value(t8, t40, 0, 0, 32);

LAB297:    t2 = (t0 + 5432);
    t6 = *((int *)t2);
    *((int *)t2) = (t6 - 1);
    goto LAB287;

LAB293:    t47 = (t41 + 4);
    *((unsigned int *)t41) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB294;

LAB295:    xsi_set_current_line(147, ng0);

LAB298:    xsi_set_current_line(148, ng0);
    t56 = (t0 + 2088);
    t58 = (t56 + 56U);
    t59 = *((char **)t58);
    memset(t48, 0, 8);
    t72 = (t48 + 4);
    t74 = (t59 + 4);
    t50 = *((unsigned int *)t59);
    t51 = (t50 >> 16);
    *((unsigned int *)t48) = t51;
    t52 = *((unsigned int *)t74);
    t53 = (t52 >> 16);
    *((unsigned int *)t72) = t53;
    t54 = *((unsigned int *)t48);
    *((unsigned int *)t48) = (t54 & 65535U);
    t55 = *((unsigned int *)t72);
    *((unsigned int *)t72) = (t55 & 65535U);
    t80 = (t0 + 2248);
    t85 = (t80 + 56U);
    t86 = *((char **)t85);
    memset(t57, 0, 8);
    xsi_vlog_unsigned_add(t57, 16, t48, 16, t86, 16);
    t87 = (t0 + 2088);
    t95 = (t0 + 2088);
    t96 = (t95 + 72U);
    t112 = *((char **)t96);
    t118 = ((char*)((ng13)));
    t119 = ((char*)((ng12)));
    xsi_vlog_convert_partindices(t73, t81, t111, ((int*)(t112)), 2, t118, 32, 1, t119, 32, 1);
    t123 = (t73 + 4);
    t60 = *((unsigned int *)t123);
    t31 = (!(t60));
    t124 = (t81 + 4);
    t61 = *((unsigned int *)t124);
    t32 = (!(t61));
    t163 = (t31 && t32);
    t125 = (t111 + 4);
    t62 = *((unsigned int *)t125);
    t164 = (!(t62));
    t179 = (t163 && t164);
    if (t179 == 1)
        goto LAB299;

LAB300:    xsi_set_current_line(149, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng14)));
    memset(t40, 0, 8);
    xsi_vlog_unsigned_rshift(t40, 32, t4, 32, t7, 32);
    t8 = (t0 + 2088);
    xsi_vlogvar_assign_value(t8, t40, 0, 0, 32);
    goto LAB297;

LAB299:    t63 = *((unsigned int *)t111);
    t180 = (t63 + 0);
    t64 = *((unsigned int *)t73);
    t65 = *((unsigned int *)t81);
    t181 = (t64 - t65);
    t182 = (t181 + 1);
    xsi_vlogvar_assign_value(t87, t57, t180, *((unsigned int *)t81), t182);
    goto LAB300;

LAB303:    t19 = *((unsigned int *)t40);
    t20 = *((unsigned int *)t9);
    *((unsigned int *)t40) = (t19 | t20);
    t21 = (t4 + 4);
    t22 = (t7 + 4);
    t23 = *((unsigned int *)t4);
    t24 = (~(t23));
    t25 = *((unsigned int *)t21);
    t26 = (~(t25));
    t27 = *((unsigned int *)t7);
    t28 = (~(t27));
    t29 = *((unsigned int *)t22);
    t30 = (~(t29));
    t31 = (t24 & t26);
    t32 = (t28 & t30);
    t33 = (~(t31));
    t34 = (~(t32));
    t35 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t35 & t33);
    t36 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t36 & t34);
    t37 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t37 & t33);
    t38 = *((unsigned int *)t40);
    *((unsigned int *)t40) = (t38 & t34);
    goto LAB305;

LAB308:    t46 = (t41 + 4);
    *((unsigned int *)t41) = 1;
    *((unsigned int *)t46) = 1;
    goto LAB309;

LAB310:    xsi_set_current_line(166, ng0);

LAB313:    xsi_set_current_line(167, ng0);
    t49 = ((char*)((ng17)));
    t56 = (t0 + 1768);
    xsi_vlogvar_assign_value(t56, t49, 0, 0, 16);
    goto LAB312;

}


extern void work_m_00000000001369689000_0633669078_init()
{
	static char *pe[] = {(void *)Always_34_0};
	xsi_register_didat("work_m_00000000001369689000_0633669078", "isim/TB_isim_beh.exe.sim/work/m_00000000001369689000_0633669078.didat");
	xsi_register_executes(pe);
}
