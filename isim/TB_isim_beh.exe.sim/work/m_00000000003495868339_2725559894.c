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
static const char *ng0 = "C:/Users/BoAdepoju/Desktop/Coding/CECS 440/Robonaut Architecture -- Verilog/v0.61/Robonaut_Architecture/alu.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {1U, 0U};
static int ng3[] = {1, 0};
static int ng4[] = {0, 0};
static unsigned int ng5[] = {2U, 0U};
static unsigned int ng6[] = {0U, 0U, 0U, 0U};
static int ng7[] = {64, 0};
static int ng8[] = {127, 0};
static unsigned int ng9[] = {1U, 0U, 0U, 0U};
static unsigned int ng10[] = {3U, 0U};
static unsigned int ng11[] = {4U, 0U};
static const char *ng12 = "Cannot divide by zero";
static unsigned int ng13[] = {5U, 0U};
static unsigned int ng14[] = {6U, 0U};
static int ng15[] = {1, 0, 0, 0, 0, 0};
static unsigned int ng16[] = {7U, 0U};
static unsigned int ng17[] = {8U, 0U};
static unsigned int ng18[] = {9U, 0U};
static unsigned int ng19[] = {10U, 0U};
static unsigned int ng20[] = {11U, 0U};
static unsigned int ng21[] = {12U, 0U};
static unsigned int ng22[] = {13U, 0U};
static unsigned int ng23[] = {14U, 0U};
static unsigned int ng24[] = {15U, 0U};
static unsigned int ng25[] = {0U, 0U, 0U, 0U, 0U, 0U};
static unsigned int ng26[] = {16U, 0U};
static unsigned int ng27[] = {4294967295U, 0U, 4294967295U, 0U, 0U, 0U};
static unsigned int ng28[] = {17U, 0U};
static unsigned int ng29[] = {18U, 0U};
static unsigned int ng30[] = {19U, 0U};
static unsigned int ng31[] = {20U, 0U};
static unsigned int ng32[] = {21U, 0U};
static unsigned int ng33[] = {22U, 0U};
static unsigned int ng34[] = {23U, 0U};
static unsigned int ng35[] = {24U, 0U};



static void Initial_36_0(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(37, ng0);

LAB2:    xsi_set_current_line(38, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 1928);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(39, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 2088);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(40, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 2248);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);
    xsi_set_current_line(41, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 2408);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);

LAB1:    return;
}

static void Always_44_1(char *t0)
{
    char t10[24];
    char t12[8];
    char t19[8];
    char t33[8];
    char t47[8];
    char t57[8];
    char t73[8];
    char t81[8];
    char t112[8];
    char t127[8];
    char t138[8];
    char t154[8];
    char t162[8];
    char t202[32];
    char t203[16];
    char t204[16];
    char t210[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    int t6;
    char *t7;
    char *t8;
    char *t9;
    char *t11;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    char *t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t40;
    char *t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    char *t45;
    char *t46;
    char *t48;
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
    int t105;
    unsigned int t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    char *t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    unsigned int t118;
    char *t119;
    char *t120;
    unsigned int t121;
    unsigned int t122;
    unsigned int t123;
    char *t124;
    char *t125;
    char *t126;
    char *t128;
    char *t129;
    char *t130;
    unsigned int t131;
    unsigned int t132;
    unsigned int t133;
    unsigned int t134;
    unsigned int t135;
    unsigned int t136;
    char *t137;
    char *t139;
    char *t140;
    unsigned int t141;
    unsigned int t142;
    unsigned int t143;
    unsigned int t144;
    unsigned int t145;
    unsigned int t146;
    unsigned int t147;
    unsigned int t148;
    unsigned int t149;
    unsigned int t150;
    unsigned int t151;
    unsigned int t152;
    char *t153;
    char *t155;
    unsigned int t156;
    unsigned int t157;
    unsigned int t158;
    unsigned int t159;
    unsigned int t160;
    char *t161;
    unsigned int t163;
    unsigned int t164;
    unsigned int t165;
    char *t166;
    char *t167;
    char *t168;
    unsigned int t169;
    unsigned int t170;
    unsigned int t171;
    unsigned int t172;
    unsigned int t173;
    unsigned int t174;
    unsigned int t175;
    char *t176;
    char *t177;
    unsigned int t178;
    unsigned int t179;
    unsigned int t180;
    unsigned int t181;
    unsigned int t182;
    unsigned int t183;
    unsigned int t184;
    unsigned int t185;
    int t186;
    int t187;
    unsigned int t188;
    unsigned int t189;
    unsigned int t190;
    unsigned int t191;
    unsigned int t192;
    unsigned int t193;
    char *t194;
    unsigned int t195;
    unsigned int t196;
    unsigned int t197;
    unsigned int t198;
    unsigned int t199;
    char *t200;
    char *t201;
    int t205;
    int t206;
    int t207;
    int t208;
    int t209;

LAB0:    t1 = (t0 + 4536U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(44, ng0);
    t2 = (t0 + 4856);
    *((int *)t2) = 1;
    t3 = (t0 + 4568);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(45, ng0);

LAB5:    xsi_set_current_line(47, ng0);
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

LAB10:    t2 = ((char*)((ng5)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB11;

LAB12:    t2 = ((char*)((ng10)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB13;

LAB14:    t2 = ((char*)((ng11)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB15;

LAB16:    t2 = ((char*)((ng13)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB17;

LAB18:    t2 = ((char*)((ng14)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB19;

LAB20:    t2 = ((char*)((ng16)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB21;

LAB22:    t2 = ((char*)((ng17)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB23;

LAB24:    t2 = ((char*)((ng18)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB25;

LAB26:    t2 = ((char*)((ng19)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB27;

LAB28:    t2 = ((char*)((ng20)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB29;

LAB30:    t2 = ((char*)((ng21)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB31;

LAB32:    t2 = ((char*)((ng22)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB33;

LAB34:    t2 = ((char*)((ng23)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB35;

LAB36:    t2 = ((char*)((ng24)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB37;

LAB38:    t2 = ((char*)((ng26)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB39;

LAB40:    t2 = ((char*)((ng28)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB41;

LAB42:    t2 = ((char*)((ng29)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB43;

LAB44:    t2 = ((char*)((ng30)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB45;

LAB46:    t2 = ((char*)((ng31)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB47;

LAB48:    t2 = ((char*)((ng32)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB49;

LAB50:    t2 = ((char*)((ng33)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB51;

LAB52:    t2 = ((char*)((ng34)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB53;

LAB54:    t2 = ((char*)((ng35)));
    t6 = xsi_vlog_unsigned_case_compare(t5, 5, t2, 5);
    if (t6 == 1)
        goto LAB55;

LAB56:
LAB58:
LAB57:    xsi_set_current_line(324, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t2, 1, t3, 64);
    t4 = (t0 + 1768);
    xsi_vlogvar_assign_value(t4, t10, 0, 0, 64);
    t7 = (t0 + 2248);
    xsi_vlogvar_assign_value(t7, t10, 64, 0, 1);

LAB59:    xsi_set_current_line(328, ng0);
    t2 = (t0 + 1768);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t33, 0, 8);
    t7 = (t33 + 4);
    t8 = (t4 + 8);
    t9 = (t4 + 12);
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t9);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t7) = t18;
    t11 = (t0 + 1928);
    xsi_vlogvar_assign_value(t11, t33, 0, 0, 1);
    xsi_set_current_line(330, ng0);
    t2 = (t0 + 1768);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng6)));
    xsi_vlog_unsigned_equal(t203, 64, t4, 64, t7, 64);
    t8 = (t203 + 4);
    t13 = *((unsigned int *)t8);
    t14 = (~(t13));
    t15 = *((unsigned int *)t203);
    t16 = (t15 & t14);
    t17 = (t16 != 0);
    if (t17 > 0)
        goto LAB464;

LAB465:    xsi_set_current_line(333, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2088);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);

LAB466:    goto LAB2;

LAB7:    xsi_set_current_line(49, ng0);

LAB60:    xsi_set_current_line(51, ng0);
    t7 = (t0 + 1048U);
    t8 = *((char **)t7);
    t7 = (t0 + 1208U);
    t9 = *((char **)t7);
    xsi_vlog_unsigned_add(t10, 65, t8, 64, t9, 64);
    t7 = (t0 + 1768);
    xsi_vlogvar_assign_value(t7, t10, 0, 0, 64);
    t11 = (t0 + 2248);
    xsi_vlogvar_assign_value(t11, t10, 64, 0, 1);
    xsi_set_current_line(53, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    memset(t12, 0, 8);
    t2 = (t12 + 4);
    t4 = (t3 + 8);
    t7 = (t3 + 12);
    t13 = *((unsigned int *)t4);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t12) = t15;
    t16 = *((unsigned int *)t7);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t2) = t18;
    t8 = ((char*)((ng1)));
    memset(t19, 0, 8);
    t9 = (t12 + 4);
    t11 = (t8 + 4);
    t20 = *((unsigned int *)t12);
    t21 = *((unsigned int *)t8);
    t22 = (t20 ^ t21);
    t23 = *((unsigned int *)t9);
    t24 = *((unsigned int *)t11);
    t25 = (t23 ^ t24);
    t26 = (t22 | t25);
    t27 = *((unsigned int *)t9);
    t28 = *((unsigned int *)t11);
    t29 = (t27 | t28);
    t30 = (~(t29));
    t31 = (t26 & t30);
    if (t31 != 0)
        goto LAB64;

LAB61:    if (t29 != 0)
        goto LAB63;

LAB62:    *((unsigned int *)t19) = 1;

LAB64:    memset(t33, 0, 8);
    t34 = (t19 + 4);
    t35 = *((unsigned int *)t34);
    t36 = (~(t35));
    t37 = *((unsigned int *)t19);
    t38 = (t37 & t36);
    t39 = (t38 & 1U);
    if (t39 != 0)
        goto LAB65;

LAB66:    if (*((unsigned int *)t34) != 0)
        goto LAB67;

LAB68:    t41 = (t33 + 4);
    t42 = *((unsigned int *)t33);
    t43 = *((unsigned int *)t41);
    t44 = (t42 || t43);
    if (t44 > 0)
        goto LAB69;

LAB70:    memcpy(t81, t33, 8);

LAB71:    memset(t112, 0, 8);
    t113 = (t81 + 4);
    t114 = *((unsigned int *)t113);
    t115 = (~(t114));
    t116 = *((unsigned int *)t81);
    t117 = (t116 & t115);
    t118 = (t117 & 1U);
    if (t118 != 0)
        goto LAB83;

LAB84:    if (*((unsigned int *)t113) != 0)
        goto LAB85;

LAB86:    t120 = (t112 + 4);
    t121 = *((unsigned int *)t112);
    t122 = *((unsigned int *)t120);
    t123 = (t121 || t122);
    if (t123 > 0)
        goto LAB87;

LAB88:    memcpy(t162, t112, 8);

LAB89:    t194 = (t162 + 4);
    t195 = *((unsigned int *)t194);
    t196 = (~(t195));
    t197 = *((unsigned int *)t162);
    t198 = (t197 & t196);
    t199 = (t198 != 0);
    if (t199 > 0)
        goto LAB101;

LAB102:    xsi_set_current_line(55, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    memset(t12, 0, 8);
    t2 = (t12 + 4);
    t4 = (t3 + 8);
    t7 = (t3 + 12);
    t13 = *((unsigned int *)t4);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t12) = t15;
    t16 = *((unsigned int *)t7);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t2) = t18;
    t8 = ((char*)((ng2)));
    memset(t19, 0, 8);
    t9 = (t12 + 4);
    t11 = (t8 + 4);
    t20 = *((unsigned int *)t12);
    t21 = *((unsigned int *)t8);
    t22 = (t20 ^ t21);
    t23 = *((unsigned int *)t9);
    t24 = *((unsigned int *)t11);
    t25 = (t23 ^ t24);
    t26 = (t22 | t25);
    t27 = *((unsigned int *)t9);
    t28 = *((unsigned int *)t11);
    t29 = (t27 | t28);
    t30 = (~(t29));
    t31 = (t26 & t30);
    if (t31 != 0)
        goto LAB107;

LAB104:    if (t29 != 0)
        goto LAB106;

LAB105:    *((unsigned int *)t19) = 1;

LAB107:    memset(t33, 0, 8);
    t34 = (t19 + 4);
    t35 = *((unsigned int *)t34);
    t36 = (~(t35));
    t37 = *((unsigned int *)t19);
    t38 = (t37 & t36);
    t39 = (t38 & 1U);
    if (t39 != 0)
        goto LAB108;

LAB109:    if (*((unsigned int *)t34) != 0)
        goto LAB110;

LAB111:    t41 = (t33 + 4);
    t42 = *((unsigned int *)t33);
    t43 = *((unsigned int *)t41);
    t44 = (t42 || t43);
    if (t44 > 0)
        goto LAB112;

LAB113:    memcpy(t81, t33, 8);

LAB114:    memset(t112, 0, 8);
    t113 = (t81 + 4);
    t114 = *((unsigned int *)t113);
    t115 = (~(t114));
    t116 = *((unsigned int *)t81);
    t117 = (t116 & t115);
    t118 = (t117 & 1U);
    if (t118 != 0)
        goto LAB126;

LAB127:    if (*((unsigned int *)t113) != 0)
        goto LAB128;

LAB129:    t120 = (t112 + 4);
    t121 = *((unsigned int *)t112);
    t122 = *((unsigned int *)t120);
    t123 = (t121 || t122);
    if (t123 > 0)
        goto LAB130;

LAB131:    memcpy(t162, t112, 8);

LAB132:    t194 = (t162 + 4);
    t195 = *((unsigned int *)t194);
    t196 = (~(t195));
    t197 = *((unsigned int *)t162);
    t198 = (t197 & t196);
    t199 = (t198 != 0);
    if (t199 > 0)
        goto LAB144;

LAB145:    xsi_set_current_line(58, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 2408);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);

LAB146:
LAB103:    goto LAB59;

LAB9:    xsi_set_current_line(62, ng0);

LAB147:    xsi_set_current_line(63, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    xsi_vlog_unsigned_minus(t10, 65, t4, 64, t7, 64);
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t10, 0, 0, 64);
    t8 = (t0 + 2248);
    xsi_vlogvar_assign_value(t8, t10, 64, 0, 1);
    xsi_set_current_line(65, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    memset(t12, 0, 8);
    t2 = (t12 + 4);
    t4 = (t3 + 8);
    t7 = (t3 + 12);
    t13 = *((unsigned int *)t4);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t12) = t15;
    t16 = *((unsigned int *)t7);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t2) = t18;
    t8 = ((char*)((ng1)));
    memset(t19, 0, 8);
    t9 = (t12 + 4);
    t11 = (t8 + 4);
    t20 = *((unsigned int *)t12);
    t21 = *((unsigned int *)t8);
    t22 = (t20 ^ t21);
    t23 = *((unsigned int *)t9);
    t24 = *((unsigned int *)t11);
    t25 = (t23 ^ t24);
    t26 = (t22 | t25);
    t27 = *((unsigned int *)t9);
    t28 = *((unsigned int *)t11);
    t29 = (t27 | t28);
    t30 = (~(t29));
    t31 = (t26 & t30);
    if (t31 != 0)
        goto LAB151;

LAB148:    if (t29 != 0)
        goto LAB150;

LAB149:    *((unsigned int *)t19) = 1;

LAB151:    memset(t33, 0, 8);
    t34 = (t19 + 4);
    t35 = *((unsigned int *)t34);
    t36 = (~(t35));
    t37 = *((unsigned int *)t19);
    t38 = (t37 & t36);
    t39 = (t38 & 1U);
    if (t39 != 0)
        goto LAB152;

LAB153:    if (*((unsigned int *)t34) != 0)
        goto LAB154;

LAB155:    t41 = (t33 + 4);
    t42 = *((unsigned int *)t33);
    t43 = *((unsigned int *)t41);
    t44 = (t42 || t43);
    if (t44 > 0)
        goto LAB156;

LAB157:    memcpy(t81, t33, 8);

LAB158:    memset(t112, 0, 8);
    t113 = (t81 + 4);
    t114 = *((unsigned int *)t113);
    t115 = (~(t114));
    t116 = *((unsigned int *)t81);
    t117 = (t116 & t115);
    t118 = (t117 & 1U);
    if (t118 != 0)
        goto LAB170;

LAB171:    if (*((unsigned int *)t113) != 0)
        goto LAB172;

LAB173:    t120 = (t112 + 4);
    t121 = *((unsigned int *)t112);
    t122 = *((unsigned int *)t120);
    t123 = (t121 || t122);
    if (t123 > 0)
        goto LAB174;

LAB175:    memcpy(t162, t112, 8);

LAB176:    t194 = (t162 + 4);
    t195 = *((unsigned int *)t194);
    t196 = (~(t195));
    t197 = *((unsigned int *)t162);
    t198 = (t197 & t196);
    t199 = (t198 != 0);
    if (t199 > 0)
        goto LAB188;

LAB189:
LAB190:    xsi_set_current_line(68, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    memset(t12, 0, 8);
    t2 = (t12 + 4);
    t4 = (t3 + 8);
    t7 = (t3 + 12);
    t13 = *((unsigned int *)t4);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t12) = t15;
    t16 = *((unsigned int *)t7);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t2) = t18;
    t8 = ((char*)((ng2)));
    memset(t19, 0, 8);
    t9 = (t12 + 4);
    t11 = (t8 + 4);
    t20 = *((unsigned int *)t12);
    t21 = *((unsigned int *)t8);
    t22 = (t20 ^ t21);
    t23 = *((unsigned int *)t9);
    t24 = *((unsigned int *)t11);
    t25 = (t23 ^ t24);
    t26 = (t22 | t25);
    t27 = *((unsigned int *)t9);
    t28 = *((unsigned int *)t11);
    t29 = (t27 | t28);
    t30 = (~(t29));
    t31 = (t26 & t30);
    if (t31 != 0)
        goto LAB194;

LAB191:    if (t29 != 0)
        goto LAB193;

LAB192:    *((unsigned int *)t19) = 1;

LAB194:    memset(t33, 0, 8);
    t34 = (t19 + 4);
    t35 = *((unsigned int *)t34);
    t36 = (~(t35));
    t37 = *((unsigned int *)t19);
    t38 = (t37 & t36);
    t39 = (t38 & 1U);
    if (t39 != 0)
        goto LAB195;

LAB196:    if (*((unsigned int *)t34) != 0)
        goto LAB197;

LAB198:    t41 = (t33 + 4);
    t42 = *((unsigned int *)t33);
    t43 = *((unsigned int *)t41);
    t44 = (t42 || t43);
    if (t44 > 0)
        goto LAB199;

LAB200:    memcpy(t81, t33, 8);

LAB201:    memset(t112, 0, 8);
    t113 = (t81 + 4);
    t114 = *((unsigned int *)t113);
    t115 = (~(t114));
    t116 = *((unsigned int *)t81);
    t117 = (t116 & t115);
    t118 = (t117 & 1U);
    if (t118 != 0)
        goto LAB213;

LAB214:    if (*((unsigned int *)t113) != 0)
        goto LAB215;

LAB216:    t120 = (t112 + 4);
    t121 = *((unsigned int *)t112);
    t122 = *((unsigned int *)t120);
    t123 = (t121 || t122);
    if (t123 > 0)
        goto LAB217;

LAB218:    memcpy(t162, t112, 8);

LAB219:    t194 = (t162 + 4);
    t195 = *((unsigned int *)t194);
    t196 = (~(t195));
    t197 = *((unsigned int *)t162);
    t198 = (t197 & t196);
    t199 = (t198 != 0);
    if (t199 > 0)
        goto LAB231;

LAB232:
LAB233:    goto LAB59;

LAB11:    xsi_set_current_line(72, ng0);

LAB234:    xsi_set_current_line(74, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    memset(t19, 0, 8);
    t3 = (t19 + 4);
    t7 = (t4 + 8);
    t8 = (t4 + 12);
    t13 = *((unsigned int *)t7);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t19) = t15;
    t16 = *((unsigned int *)t8);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t3) = t18;
    t9 = (t0 + 1048U);
    t11 = *((char **)t9);
    memset(t33, 0, 8);
    t9 = (t33 + 4);
    t32 = (t11 + 8);
    t34 = (t11 + 12);
    t20 = *((unsigned int *)t32);
    t21 = (t20 >> 31);
    t22 = (t21 & 1);
    *((unsigned int *)t33) = t22;
    t23 = *((unsigned int *)t34);
    t24 = (t23 >> 31);
    t25 = (t24 & 1);
    *((unsigned int *)t9) = t25;
    xsi_vlogtype_concat(t12, 2, 2, 2U, t33, 1, t19, 1);

LAB235:    t40 = ((char*)((ng1)));
    t105 = xsi_vlog_unsigned_case_compare(t12, 2, t40, 2);
    if (t105 == 1)
        goto LAB236;

LAB237:    t2 = ((char*)((ng2)));
    t6 = xsi_vlog_unsigned_case_compare(t12, 2, t2, 2);
    if (t6 == 1)
        goto LAB238;

LAB239:    t2 = ((char*)((ng5)));
    t6 = xsi_vlog_unsigned_case_compare(t12, 2, t2, 2);
    if (t6 == 1)
        goto LAB240;

LAB241:    t2 = ((char*)((ng10)));
    t6 = xsi_vlog_unsigned_case_compare(t12, 2, t2, 2);
    if (t6 == 1)
        goto LAB242;

LAB243:
LAB244:    goto LAB59;

LAB13:    xsi_set_current_line(162, ng0);
    t3 = (t0 + 3048);
    t4 = (t3 + 56U);
    t7 = *((char **)t4);
    xsi_vlog_get_part_select_value(t203, 64, t7, 127, 64);
    t8 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t8, 1, t203, 64);
    t9 = (t0 + 1768);
    xsi_vlogvar_assign_value(t9, t10, 0, 0, 64);
    t11 = (t0 + 2248);
    xsi_vlogvar_assign_value(t11, t10, 64, 0, 1);
    goto LAB59;

LAB15:    xsi_set_current_line(163, ng0);

LAB309:    xsi_set_current_line(164, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    t3 = ((char*)((ng6)));
    xsi_vlog_unsigned_equal(t203, 64, t4, 64, t3, 64);
    t7 = (t203 + 4);
    t13 = *((unsigned int *)t7);
    t14 = (~(t13));
    t15 = *((unsigned int *)t203);
    t16 = (t15 & t14);
    t17 = (t16 != 0);
    if (t17 > 0)
        goto LAB310;

LAB311:    xsi_set_current_line(167, ng0);

LAB313:    xsi_set_current_line(168, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    memset(t33, 0, 8);
    t2 = (t33 + 4);
    t4 = (t3 + 8);
    t7 = (t3 + 12);
    t13 = *((unsigned int *)t4);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t7);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t2) = t18;
    t8 = (t0 + 1048U);
    t9 = *((char **)t8);
    memset(t47, 0, 8);
    t8 = (t47 + 4);
    t11 = (t9 + 8);
    t32 = (t9 + 12);
    t20 = *((unsigned int *)t11);
    t21 = (t20 >> 31);
    t22 = (t21 & 1);
    *((unsigned int *)t47) = t22;
    t23 = *((unsigned int *)t32);
    t24 = (t23 >> 31);
    t25 = (t24 & 1);
    *((unsigned int *)t8) = t25;
    xsi_vlogtype_concat(t19, 2, 2, 2U, t47, 1, t33, 1);

LAB314:    t34 = ((char*)((ng1)));
    t6 = xsi_vlog_unsigned_case_compare(t19, 2, t34, 2);
    if (t6 == 1)
        goto LAB315;

LAB316:    t2 = ((char*)((ng2)));
    t6 = xsi_vlog_unsigned_case_compare(t19, 2, t2, 2);
    if (t6 == 1)
        goto LAB317;

LAB318:    t2 = ((char*)((ng5)));
    t6 = xsi_vlog_unsigned_case_compare(t19, 2, t2, 2);
    if (t6 == 1)
        goto LAB319;

LAB320:    t2 = ((char*)((ng10)));
    t6 = xsi_vlog_unsigned_case_compare(t19, 2, t2, 2);
    if (t6 == 1)
        goto LAB321;

LAB322:
LAB323:
LAB312:    goto LAB59;

LAB17:    xsi_set_current_line(267, ng0);
    t3 = (t0 + 3368);
    t4 = (t3 + 56U);
    t7 = *((char **)t4);
    xsi_vlog_get_part_select_value(t203, 64, t7, 127, 64);
    t8 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t8, 1, t203, 64);
    t9 = (t0 + 1768);
    xsi_vlogvar_assign_value(t9, t10, 0, 0, 64);
    t11 = (t0 + 2248);
    xsi_vlogvar_assign_value(t11, t10, 64, 0, 1);
    goto LAB59;

LAB19:    xsi_set_current_line(269, ng0);

LAB420:    xsi_set_current_line(270, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    t3 = ((char*)((ng15)));
    xsi_vlog_unsigned_add(t10, 65, t4, 64, t3, 32);
    t7 = (t0 + 1768);
    xsi_vlogvar_assign_value(t7, t10, 0, 0, 64);
    t8 = (t0 + 2248);
    xsi_vlogvar_assign_value(t8, t10, 64, 0, 1);
    xsi_set_current_line(272, ng0);
    t2 = (t0 + 1768);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t33, 0, 8);
    t7 = (t33 + 4);
    t8 = (t4 + 8);
    t9 = (t4 + 12);
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t9);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t7) = t18;
    t11 = (t0 + 1208U);
    t32 = *((char **)t11);
    memset(t47, 0, 8);
    t11 = (t47 + 4);
    t34 = (t32 + 8);
    t40 = (t32 + 12);
    t20 = *((unsigned int *)t34);
    t21 = (t20 >> 31);
    t22 = (t21 & 1);
    *((unsigned int *)t47) = t22;
    t23 = *((unsigned int *)t40);
    t24 = (t23 >> 31);
    t25 = (t24 & 1);
    *((unsigned int *)t11) = t25;
    memset(t57, 0, 8);
    t41 = (t33 + 4);
    t45 = (t47 + 4);
    t26 = *((unsigned int *)t33);
    t27 = *((unsigned int *)t47);
    t28 = (t26 ^ t27);
    t29 = *((unsigned int *)t41);
    t30 = *((unsigned int *)t45);
    t31 = (t29 ^ t30);
    t35 = (t28 | t31);
    t36 = *((unsigned int *)t41);
    t37 = *((unsigned int *)t45);
    t38 = (t36 | t37);
    t39 = (~(t38));
    t42 = (t35 & t39);
    if (t42 != 0)
        goto LAB422;

LAB421:    if (t38 != 0)
        goto LAB423;

LAB424:    t48 = (t57 + 4);
    t43 = *((unsigned int *)t48);
    t44 = (~(t43));
    t50 = *((unsigned int *)t57);
    t51 = (t50 & t44);
    t52 = (t51 != 0);
    if (t52 > 0)
        goto LAB425;

LAB426:    xsi_set_current_line(275, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 2408);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);

LAB427:    goto LAB59;

LAB21:    xsi_set_current_line(280, ng0);

LAB428:    xsi_set_current_line(282, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    t3 = ((char*)((ng9)));
    xsi_vlog_unsigned_minus(t203, 64, t4, 64, t3, 64);
    t7 = (t0 + 1768);
    xsi_vlogvar_assign_value(t7, t203, 0, 0, 64);
    xsi_set_current_line(284, ng0);
    t2 = (t0 + 1768);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t33, 0, 8);
    t7 = (t33 + 4);
    t8 = (t4 + 8);
    t9 = (t4 + 12);
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t9);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t7) = t18;
    t11 = (t0 + 1208U);
    t32 = *((char **)t11);
    memset(t47, 0, 8);
    t11 = (t47 + 4);
    t34 = (t32 + 8);
    t40 = (t32 + 12);
    t20 = *((unsigned int *)t34);
    t21 = (t20 >> 31);
    t22 = (t21 & 1);
    *((unsigned int *)t47) = t22;
    t23 = *((unsigned int *)t40);
    t24 = (t23 >> 31);
    t25 = (t24 & 1);
    *((unsigned int *)t11) = t25;
    memset(t57, 0, 8);
    t41 = (t33 + 4);
    t45 = (t47 + 4);
    t26 = *((unsigned int *)t33);
    t27 = *((unsigned int *)t47);
    t28 = (t26 ^ t27);
    t29 = *((unsigned int *)t41);
    t30 = *((unsigned int *)t45);
    t31 = (t29 ^ t30);
    t35 = (t28 | t31);
    t36 = *((unsigned int *)t41);
    t37 = *((unsigned int *)t45);
    t38 = (t36 | t37);
    t39 = (~(t38));
    t42 = (t35 & t39);
    if (t42 != 0)
        goto LAB430;

LAB429:    if (t38 != 0)
        goto LAB431;

LAB432:    t48 = (t57 + 4);
    t43 = *((unsigned int *)t48);
    t44 = (~(t43));
    t50 = *((unsigned int *)t57);
    t51 = (t50 & t44);
    t52 = (t51 != 0);
    if (t52 > 0)
        goto LAB433;

LAB434:    xsi_set_current_line(287, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 2408);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);

LAB435:    goto LAB59;

LAB23:    xsi_set_current_line(291, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    t13 = 0;

LAB439:    t14 = (t13 < 2);
    if (t14 == 1)
        goto LAB440;

LAB441:    t48 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t48, 1, t203, 64);
    t49 = (t0 + 1768);
    xsi_vlogvar_assign_value(t49, t10, 0, 0, 64);
    t56 = (t0 + 2248);
    xsi_vlogvar_assign_value(t56, t10, 64, 0, 1);
    goto LAB59;

LAB25:    xsi_set_current_line(292, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    t13 = 0;

LAB445:    t14 = (t13 < 2);
    if (t14 == 1)
        goto LAB446;

LAB447:    t48 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t48, 1, t203, 64);
    t49 = (t0 + 1768);
    xsi_vlogvar_assign_value(t49, t10, 0, 0, 64);
    t56 = (t0 + 2248);
    xsi_vlogvar_assign_value(t56, t10, 64, 0, 1);
    goto LAB59;

LAB27:    xsi_set_current_line(293, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    t13 = 0;

LAB451:    t14 = (t13 < 2);
    if (t14 == 1)
        goto LAB452;

LAB453:    t40 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t40, 1, t203, 64);
    t41 = (t0 + 1768);
    xsi_vlogvar_assign_value(t41, t10, 0, 0, 64);
    t45 = (t0 + 2248);
    xsi_vlogvar_assign_value(t45, t10, 64, 0, 1);
    goto LAB59;

LAB29:    xsi_set_current_line(294, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    xsi_vlogtype_unsigned_bit_neg(t203, 64, t4, 64);
    t3 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t3, 1, t203, 64);
    t7 = (t0 + 1768);
    xsi_vlogvar_assign_value(t7, t10, 0, 0, 64);
    t8 = (t0 + 2248);
    xsi_vlogvar_assign_value(t8, t10, 64, 0, 1);
    goto LAB59;

LAB31:    xsi_set_current_line(295, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    xsi_vlog_unsigned_unary_minus(t203, 64, t4, 64);
    t3 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t3, 1, t203, 64);
    t7 = (t0 + 1768);
    xsi_vlogvar_assign_value(t7, t10, 0, 0, 64);
    t8 = (t0 + 2248);
    xsi_vlogvar_assign_value(t8, t10, 64, 0, 1);
    goto LAB59;

LAB33:    xsi_set_current_line(296, ng0);

LAB454:    xsi_set_current_line(297, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    memset(t33, 0, 8);
    t3 = (t33 + 4);
    t7 = (t4 + 8);
    t8 = (t4 + 12);
    t13 = *((unsigned int *)t7);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t8);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t3) = t18;
    t9 = (t0 + 2248);
    xsi_vlogvar_assign_value(t9, t33, 0, 0, 1);
    xsi_set_current_line(298, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    memset(t33, 0, 8);
    t2 = (t33 + 4);
    t4 = (t3 + 8);
    t7 = (t3 + 12);
    t13 = *((unsigned int *)t4);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t7);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t2) = t18;
    t8 = (t0 + 2568);
    xsi_vlogvar_assign_value(t8, t33, 0, 0, 1);
    xsi_set_current_line(299, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t203, 64, t3, 64, t2, 32);
    t4 = (t0 + 1768);
    xsi_vlogvar_assign_value(t4, t203, 0, 0, 64);
    goto LAB59;

LAB35:    xsi_set_current_line(301, ng0);

LAB455:    xsi_set_current_line(302, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    memset(t33, 0, 8);
    t3 = (t33 + 4);
    t7 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t14 = (t13 >> 0);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t7);
    t17 = (t16 >> 0);
    t18 = (t17 & 1);
    *((unsigned int *)t3) = t18;
    t8 = (t0 + 2248);
    xsi_vlogvar_assign_value(t8, t33, 0, 0, 1);
    xsi_set_current_line(303, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    memset(t33, 0, 8);
    t2 = (t33 + 4);
    t4 = (t3 + 4);
    t13 = *((unsigned int *)t3);
    t14 = (t13 >> 0);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t4);
    t17 = (t16 >> 0);
    t18 = (t17 & 1);
    *((unsigned int *)t2) = t18;
    t7 = (t0 + 2568);
    xsi_vlogvar_assign_value(t7, t33, 0, 0, 1);
    xsi_set_current_line(304, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t203, 64, t3, 64, t2, 32);
    t4 = (t0 + 1768);
    xsi_vlogvar_assign_value(t4, t203, 0, 0, 64);
    goto LAB59;

LAB37:    xsi_set_current_line(306, ng0);
    t3 = ((char*)((ng25)));
    t4 = (t0 + 1768);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 64);
    t7 = (t0 + 2248);
    xsi_vlogvar_assign_value(t7, t3, 64, 0, 1);
    goto LAB59;

LAB39:    xsi_set_current_line(307, ng0);
    t3 = ((char*)((ng27)));
    t4 = (t0 + 1768);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 64);
    t7 = (t0 + 2248);
    xsi_vlogvar_assign_value(t7, t3, 64, 0, 1);
    goto LAB59;

LAB41:    xsi_set_current_line(308, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t3, 1, t4, 64);
    t7 = (t0 + 1768);
    xsi_vlogvar_assign_value(t7, t10, 0, 0, 64);
    t8 = (t0 + 2248);
    xsi_vlogvar_assign_value(t8, t10, 64, 0, 1);
    goto LAB59;

LAB43:    xsi_set_current_line(309, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    t3 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t3, 1, t4, 64);
    t7 = (t0 + 1768);
    xsi_vlogvar_assign_value(t7, t10, 0, 0, 64);
    t8 = (t0 + 2248);
    xsi_vlogvar_assign_value(t8, t10, 64, 0, 1);
    goto LAB59;

LAB45:    xsi_set_current_line(311, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t204, 63, t4, 63, 1);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    memset(t33, 0, 8);
    t3 = (t33 + 4);
    t8 = (t7 + 8);
    t9 = (t7 + 12);
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t9);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t3) = t18;
    xsi_vlogtype_concat(t203, 64, 64, 2U, t33, 1, t204, 63);
    t11 = (t0 + 1768);
    xsi_vlogvar_assign_value(t11, t203, 0, 0, 64);
    goto LAB59;

LAB47:    xsi_set_current_line(312, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    xsi_vlog_unsigned_unary_minus(t203, 64, t4, 64);
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t203, 0, 0, 64);
    goto LAB59;

LAB49:    xsi_set_current_line(313, ng0);

LAB456:    xsi_set_current_line(314, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    memset(t33, 0, 8);
    t3 = (t33 + 4);
    t7 = (t4 + 8);
    t8 = (t4 + 12);
    t13 = *((unsigned int *)t7);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t8);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t3) = t18;
    t9 = (t0 + 2248);
    xsi_vlogvar_assign_value(t9, t33, 0, 0, 1);
    xsi_set_current_line(315, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    memset(t33, 0, 8);
    t2 = (t33 + 4);
    t4 = (t3 + 8);
    t7 = (t3 + 12);
    t13 = *((unsigned int *)t4);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t7);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t2) = t18;
    t8 = (t0 + 2568);
    xsi_vlogvar_assign_value(t8, t33, 0, 0, 1);
    xsi_set_current_line(316, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t203, 64, t3, 64, t2, 32);
    t4 = (t0 + 1768);
    xsi_vlogvar_assign_value(t4, t203, 0, 0, 64);
    xsi_set_current_line(317, ng0);
    t2 = (t0 + 1768);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t33, 0, 8);
    t7 = (t33 + 4);
    t8 = (t4 + 8);
    t9 = (t4 + 12);
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t9);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t7) = t18;
    t11 = (t0 + 1208U);
    t32 = *((char **)t11);
    memset(t47, 0, 8);
    t11 = (t47 + 4);
    t34 = (t32 + 8);
    t40 = (t32 + 12);
    t20 = *((unsigned int *)t34);
    t21 = (t20 >> 31);
    t22 = (t21 & 1);
    *((unsigned int *)t47) = t22;
    t23 = *((unsigned int *)t40);
    t24 = (t23 >> 31);
    t25 = (t24 & 1);
    *((unsigned int *)t11) = t25;
    memset(t57, 0, 8);
    t41 = (t33 + 4);
    t45 = (t47 + 4);
    t26 = *((unsigned int *)t33);
    t27 = *((unsigned int *)t47);
    t28 = (t26 ^ t27);
    t29 = *((unsigned int *)t41);
    t30 = *((unsigned int *)t45);
    t31 = (t29 ^ t30);
    t35 = (t28 | t31);
    t36 = *((unsigned int *)t41);
    t37 = *((unsigned int *)t45);
    t38 = (t36 | t37);
    t39 = (~(t38));
    t42 = (t35 & t39);
    if (t42 != 0)
        goto LAB458;

LAB457:    if (t38 != 0)
        goto LAB459;

LAB460:    t48 = (t57 + 4);
    t43 = *((unsigned int *)t48);
    t44 = (~(t43));
    t50 = *((unsigned int *)t57);
    t51 = (t50 & t44);
    t52 = (t51 != 0);
    if (t52 > 0)
        goto LAB461;

LAB462:
LAB463:    goto LAB59;

LAB51:    xsi_set_current_line(321, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    xsi_vlogtype_unsigned_bit_neg(t203, 64, t4, 64);
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t203, 0, 0, 64);
    goto LAB59;

LAB53:    xsi_set_current_line(322, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t204, 63, t4, 63, 1);
    t3 = (t0 + 1208U);
    t7 = *((char **)t3);
    memset(t33, 0, 8);
    t3 = (t33 + 4);
    t8 = (t7 + 4);
    t13 = *((unsigned int *)t7);
    t14 = (t13 >> 0);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t8);
    t17 = (t16 >> 0);
    t18 = (t17 & 1);
    *((unsigned int *)t3) = t18;
    xsi_vlogtype_concat(t203, 64, 64, 2U, t33, 1, t204, 63);
    t9 = (t0 + 1768);
    xsi_vlogvar_assign_value(t9, t203, 0, 0, 64);
    goto LAB59;

LAB55:    xsi_set_current_line(323, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    memset(t33, 0, 8);
    t3 = (t33 + 4);
    t7 = (t4 + 8);
    t8 = (t4 + 12);
    t13 = *((unsigned int *)t7);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t8);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t3) = t18;
    t9 = (t0 + 1208U);
    t11 = *((char **)t9);
    xsi_vlog_get_part_select_value(t204, 63, t11, 62, 0);
    xsi_vlogtype_concat(t203, 64, 64, 2U, t204, 63, t33, 1);
    t9 = (t0 + 1768);
    xsi_vlogvar_assign_value(t9, t203, 0, 0, 64);
    goto LAB59;

LAB63:    t32 = (t19 + 4);
    *((unsigned int *)t19) = 1;
    *((unsigned int *)t32) = 1;
    goto LAB64;

LAB65:    *((unsigned int *)t33) = 1;
    goto LAB68;

LAB67:    t40 = (t33 + 4);
    *((unsigned int *)t33) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB68;

LAB69:    t45 = (t0 + 1208U);
    t46 = *((char **)t45);
    memset(t47, 0, 8);
    t45 = (t47 + 4);
    t48 = (t46 + 8);
    t49 = (t46 + 12);
    t50 = *((unsigned int *)t48);
    t51 = (t50 >> 31);
    t52 = (t51 & 1);
    *((unsigned int *)t47) = t52;
    t53 = *((unsigned int *)t49);
    t54 = (t53 >> 31);
    t55 = (t54 & 1);
    *((unsigned int *)t45) = t55;
    t56 = ((char*)((ng1)));
    memset(t57, 0, 8);
    t58 = (t47 + 4);
    t59 = (t56 + 4);
    t60 = *((unsigned int *)t47);
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
        goto LAB75;

LAB72:    if (t69 != 0)
        goto LAB74;

LAB73:    *((unsigned int *)t57) = 1;

LAB75:    memset(t73, 0, 8);
    t74 = (t57 + 4);
    t75 = *((unsigned int *)t74);
    t76 = (~(t75));
    t77 = *((unsigned int *)t57);
    t78 = (t77 & t76);
    t79 = (t78 & 1U);
    if (t79 != 0)
        goto LAB76;

LAB77:    if (*((unsigned int *)t74) != 0)
        goto LAB78;

LAB79:    t82 = *((unsigned int *)t33);
    t83 = *((unsigned int *)t73);
    t84 = (t82 & t83);
    *((unsigned int *)t81) = t84;
    t85 = (t33 + 4);
    t86 = (t73 + 4);
    t87 = (t81 + 4);
    t88 = *((unsigned int *)t85);
    t89 = *((unsigned int *)t86);
    t90 = (t88 | t89);
    *((unsigned int *)t87) = t90;
    t91 = *((unsigned int *)t87);
    t92 = (t91 != 0);
    if (t92 == 1)
        goto LAB80;

LAB81:
LAB82:    goto LAB71;

LAB74:    t72 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t72) = 1;
    goto LAB75;

LAB76:    *((unsigned int *)t73) = 1;
    goto LAB79;

LAB78:    t80 = (t73 + 4);
    *((unsigned int *)t73) = 1;
    *((unsigned int *)t80) = 1;
    goto LAB79;

LAB80:    t93 = *((unsigned int *)t81);
    t94 = *((unsigned int *)t87);
    *((unsigned int *)t81) = (t93 | t94);
    t95 = (t33 + 4);
    t96 = (t73 + 4);
    t97 = *((unsigned int *)t33);
    t98 = (~(t97));
    t99 = *((unsigned int *)t95);
    t100 = (~(t99));
    t101 = *((unsigned int *)t73);
    t102 = (~(t101));
    t103 = *((unsigned int *)t96);
    t104 = (~(t103));
    t6 = (t98 & t100);
    t105 = (t102 & t104);
    t106 = (~(t6));
    t107 = (~(t105));
    t108 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t108 & t106);
    t109 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t109 & t107);
    t110 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t110 & t106);
    t111 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t111 & t107);
    goto LAB82;

LAB83:    *((unsigned int *)t112) = 1;
    goto LAB86;

LAB85:    t119 = (t112 + 4);
    *((unsigned int *)t112) = 1;
    *((unsigned int *)t119) = 1;
    goto LAB86;

LAB87:    t124 = (t0 + 1768);
    t125 = (t124 + 56U);
    t126 = *((char **)t125);
    memset(t127, 0, 8);
    t128 = (t127 + 4);
    t129 = (t126 + 8);
    t130 = (t126 + 12);
    t131 = *((unsigned int *)t129);
    t132 = (t131 >> 31);
    t133 = (t132 & 1);
    *((unsigned int *)t127) = t133;
    t134 = *((unsigned int *)t130);
    t135 = (t134 >> 31);
    t136 = (t135 & 1);
    *((unsigned int *)t128) = t136;
    t137 = ((char*)((ng2)));
    memset(t138, 0, 8);
    t139 = (t127 + 4);
    t140 = (t137 + 4);
    t141 = *((unsigned int *)t127);
    t142 = *((unsigned int *)t137);
    t143 = (t141 ^ t142);
    t144 = *((unsigned int *)t139);
    t145 = *((unsigned int *)t140);
    t146 = (t144 ^ t145);
    t147 = (t143 | t146);
    t148 = *((unsigned int *)t139);
    t149 = *((unsigned int *)t140);
    t150 = (t148 | t149);
    t151 = (~(t150));
    t152 = (t147 & t151);
    if (t152 != 0)
        goto LAB93;

LAB90:    if (t150 != 0)
        goto LAB92;

LAB91:    *((unsigned int *)t138) = 1;

LAB93:    memset(t154, 0, 8);
    t155 = (t138 + 4);
    t156 = *((unsigned int *)t155);
    t157 = (~(t156));
    t158 = *((unsigned int *)t138);
    t159 = (t158 & t157);
    t160 = (t159 & 1U);
    if (t160 != 0)
        goto LAB94;

LAB95:    if (*((unsigned int *)t155) != 0)
        goto LAB96;

LAB97:    t163 = *((unsigned int *)t112);
    t164 = *((unsigned int *)t154);
    t165 = (t163 & t164);
    *((unsigned int *)t162) = t165;
    t166 = (t112 + 4);
    t167 = (t154 + 4);
    t168 = (t162 + 4);
    t169 = *((unsigned int *)t166);
    t170 = *((unsigned int *)t167);
    t171 = (t169 | t170);
    *((unsigned int *)t168) = t171;
    t172 = *((unsigned int *)t168);
    t173 = (t172 != 0);
    if (t173 == 1)
        goto LAB98;

LAB99:
LAB100:    goto LAB89;

LAB92:    t153 = (t138 + 4);
    *((unsigned int *)t138) = 1;
    *((unsigned int *)t153) = 1;
    goto LAB93;

LAB94:    *((unsigned int *)t154) = 1;
    goto LAB97;

LAB96:    t161 = (t154 + 4);
    *((unsigned int *)t154) = 1;
    *((unsigned int *)t161) = 1;
    goto LAB97;

LAB98:    t174 = *((unsigned int *)t162);
    t175 = *((unsigned int *)t168);
    *((unsigned int *)t162) = (t174 | t175);
    t176 = (t112 + 4);
    t177 = (t154 + 4);
    t178 = *((unsigned int *)t112);
    t179 = (~(t178));
    t180 = *((unsigned int *)t176);
    t181 = (~(t180));
    t182 = *((unsigned int *)t154);
    t183 = (~(t182));
    t184 = *((unsigned int *)t177);
    t185 = (~(t184));
    t186 = (t179 & t181);
    t187 = (t183 & t185);
    t188 = (~(t186));
    t189 = (~(t187));
    t190 = *((unsigned int *)t168);
    *((unsigned int *)t168) = (t190 & t188);
    t191 = *((unsigned int *)t168);
    *((unsigned int *)t168) = (t191 & t189);
    t192 = *((unsigned int *)t162);
    *((unsigned int *)t162) = (t192 & t188);
    t193 = *((unsigned int *)t162);
    *((unsigned int *)t162) = (t193 & t189);
    goto LAB100;

LAB101:    xsi_set_current_line(54, ng0);
    t200 = ((char*)((ng3)));
    t201 = (t0 + 2408);
    xsi_vlogvar_assign_value(t201, t200, 0, 0, 1);
    goto LAB103;

LAB106:    t32 = (t19 + 4);
    *((unsigned int *)t19) = 1;
    *((unsigned int *)t32) = 1;
    goto LAB107;

LAB108:    *((unsigned int *)t33) = 1;
    goto LAB111;

LAB110:    t40 = (t33 + 4);
    *((unsigned int *)t33) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB111;

LAB112:    t45 = (t0 + 1208U);
    t46 = *((char **)t45);
    memset(t47, 0, 8);
    t45 = (t47 + 4);
    t48 = (t46 + 8);
    t49 = (t46 + 12);
    t50 = *((unsigned int *)t48);
    t51 = (t50 >> 31);
    t52 = (t51 & 1);
    *((unsigned int *)t47) = t52;
    t53 = *((unsigned int *)t49);
    t54 = (t53 >> 31);
    t55 = (t54 & 1);
    *((unsigned int *)t45) = t55;
    t56 = ((char*)((ng2)));
    memset(t57, 0, 8);
    t58 = (t47 + 4);
    t59 = (t56 + 4);
    t60 = *((unsigned int *)t47);
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
        goto LAB118;

LAB115:    if (t69 != 0)
        goto LAB117;

LAB116:    *((unsigned int *)t57) = 1;

LAB118:    memset(t73, 0, 8);
    t74 = (t57 + 4);
    t75 = *((unsigned int *)t74);
    t76 = (~(t75));
    t77 = *((unsigned int *)t57);
    t78 = (t77 & t76);
    t79 = (t78 & 1U);
    if (t79 != 0)
        goto LAB119;

LAB120:    if (*((unsigned int *)t74) != 0)
        goto LAB121;

LAB122:    t82 = *((unsigned int *)t33);
    t83 = *((unsigned int *)t73);
    t84 = (t82 & t83);
    *((unsigned int *)t81) = t84;
    t85 = (t33 + 4);
    t86 = (t73 + 4);
    t87 = (t81 + 4);
    t88 = *((unsigned int *)t85);
    t89 = *((unsigned int *)t86);
    t90 = (t88 | t89);
    *((unsigned int *)t87) = t90;
    t91 = *((unsigned int *)t87);
    t92 = (t91 != 0);
    if (t92 == 1)
        goto LAB123;

LAB124:
LAB125:    goto LAB114;

LAB117:    t72 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t72) = 1;
    goto LAB118;

LAB119:    *((unsigned int *)t73) = 1;
    goto LAB122;

LAB121:    t80 = (t73 + 4);
    *((unsigned int *)t73) = 1;
    *((unsigned int *)t80) = 1;
    goto LAB122;

LAB123:    t93 = *((unsigned int *)t81);
    t94 = *((unsigned int *)t87);
    *((unsigned int *)t81) = (t93 | t94);
    t95 = (t33 + 4);
    t96 = (t73 + 4);
    t97 = *((unsigned int *)t33);
    t98 = (~(t97));
    t99 = *((unsigned int *)t95);
    t100 = (~(t99));
    t101 = *((unsigned int *)t73);
    t102 = (~(t101));
    t103 = *((unsigned int *)t96);
    t104 = (~(t103));
    t6 = (t98 & t100);
    t105 = (t102 & t104);
    t106 = (~(t6));
    t107 = (~(t105));
    t108 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t108 & t106);
    t109 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t109 & t107);
    t110 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t110 & t106);
    t111 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t111 & t107);
    goto LAB125;

LAB126:    *((unsigned int *)t112) = 1;
    goto LAB129;

LAB128:    t119 = (t112 + 4);
    *((unsigned int *)t112) = 1;
    *((unsigned int *)t119) = 1;
    goto LAB129;

LAB130:    t124 = (t0 + 1768);
    t125 = (t124 + 56U);
    t126 = *((char **)t125);
    memset(t127, 0, 8);
    t128 = (t127 + 4);
    t129 = (t126 + 8);
    t130 = (t126 + 12);
    t131 = *((unsigned int *)t129);
    t132 = (t131 >> 31);
    t133 = (t132 & 1);
    *((unsigned int *)t127) = t133;
    t134 = *((unsigned int *)t130);
    t135 = (t134 >> 31);
    t136 = (t135 & 1);
    *((unsigned int *)t128) = t136;
    t137 = ((char*)((ng1)));
    memset(t138, 0, 8);
    t139 = (t127 + 4);
    t140 = (t137 + 4);
    t141 = *((unsigned int *)t127);
    t142 = *((unsigned int *)t137);
    t143 = (t141 ^ t142);
    t144 = *((unsigned int *)t139);
    t145 = *((unsigned int *)t140);
    t146 = (t144 ^ t145);
    t147 = (t143 | t146);
    t148 = *((unsigned int *)t139);
    t149 = *((unsigned int *)t140);
    t150 = (t148 | t149);
    t151 = (~(t150));
    t152 = (t147 & t151);
    if (t152 != 0)
        goto LAB136;

LAB133:    if (t150 != 0)
        goto LAB135;

LAB134:    *((unsigned int *)t138) = 1;

LAB136:    memset(t154, 0, 8);
    t155 = (t138 + 4);
    t156 = *((unsigned int *)t155);
    t157 = (~(t156));
    t158 = *((unsigned int *)t138);
    t159 = (t158 & t157);
    t160 = (t159 & 1U);
    if (t160 != 0)
        goto LAB137;

LAB138:    if (*((unsigned int *)t155) != 0)
        goto LAB139;

LAB140:    t163 = *((unsigned int *)t112);
    t164 = *((unsigned int *)t154);
    t165 = (t163 & t164);
    *((unsigned int *)t162) = t165;
    t166 = (t112 + 4);
    t167 = (t154 + 4);
    t168 = (t162 + 4);
    t169 = *((unsigned int *)t166);
    t170 = *((unsigned int *)t167);
    t171 = (t169 | t170);
    *((unsigned int *)t168) = t171;
    t172 = *((unsigned int *)t168);
    t173 = (t172 != 0);
    if (t173 == 1)
        goto LAB141;

LAB142:
LAB143:    goto LAB132;

LAB135:    t153 = (t138 + 4);
    *((unsigned int *)t138) = 1;
    *((unsigned int *)t153) = 1;
    goto LAB136;

LAB137:    *((unsigned int *)t154) = 1;
    goto LAB140;

LAB139:    t161 = (t154 + 4);
    *((unsigned int *)t154) = 1;
    *((unsigned int *)t161) = 1;
    goto LAB140;

LAB141:    t174 = *((unsigned int *)t162);
    t175 = *((unsigned int *)t168);
    *((unsigned int *)t162) = (t174 | t175);
    t176 = (t112 + 4);
    t177 = (t154 + 4);
    t178 = *((unsigned int *)t112);
    t179 = (~(t178));
    t180 = *((unsigned int *)t176);
    t181 = (~(t180));
    t182 = *((unsigned int *)t154);
    t183 = (~(t182));
    t184 = *((unsigned int *)t177);
    t185 = (~(t184));
    t186 = (t179 & t181);
    t187 = (t183 & t185);
    t188 = (~(t186));
    t189 = (~(t187));
    t190 = *((unsigned int *)t168);
    *((unsigned int *)t168) = (t190 & t188);
    t191 = *((unsigned int *)t168);
    *((unsigned int *)t168) = (t191 & t189);
    t192 = *((unsigned int *)t162);
    *((unsigned int *)t162) = (t192 & t188);
    t193 = *((unsigned int *)t162);
    *((unsigned int *)t162) = (t193 & t189);
    goto LAB143;

LAB144:    xsi_set_current_line(56, ng0);
    t200 = ((char*)((ng3)));
    t201 = (t0 + 2408);
    xsi_vlogvar_assign_value(t201, t200, 0, 0, 1);
    goto LAB146;

LAB150:    t32 = (t19 + 4);
    *((unsigned int *)t19) = 1;
    *((unsigned int *)t32) = 1;
    goto LAB151;

LAB152:    *((unsigned int *)t33) = 1;
    goto LAB155;

LAB154:    t40 = (t33 + 4);
    *((unsigned int *)t33) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB155;

LAB156:    t45 = (t0 + 1208U);
    t46 = *((char **)t45);
    memset(t47, 0, 8);
    t45 = (t47 + 4);
    t48 = (t46 + 8);
    t49 = (t46 + 12);
    t50 = *((unsigned int *)t48);
    t51 = (t50 >> 31);
    t52 = (t51 & 1);
    *((unsigned int *)t47) = t52;
    t53 = *((unsigned int *)t49);
    t54 = (t53 >> 31);
    t55 = (t54 & 1);
    *((unsigned int *)t45) = t55;
    t56 = ((char*)((ng2)));
    memset(t57, 0, 8);
    t58 = (t47 + 4);
    t59 = (t56 + 4);
    t60 = *((unsigned int *)t47);
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
        goto LAB162;

LAB159:    if (t69 != 0)
        goto LAB161;

LAB160:    *((unsigned int *)t57) = 1;

LAB162:    memset(t73, 0, 8);
    t74 = (t57 + 4);
    t75 = *((unsigned int *)t74);
    t76 = (~(t75));
    t77 = *((unsigned int *)t57);
    t78 = (t77 & t76);
    t79 = (t78 & 1U);
    if (t79 != 0)
        goto LAB163;

LAB164:    if (*((unsigned int *)t74) != 0)
        goto LAB165;

LAB166:    t82 = *((unsigned int *)t33);
    t83 = *((unsigned int *)t73);
    t84 = (t82 & t83);
    *((unsigned int *)t81) = t84;
    t85 = (t33 + 4);
    t86 = (t73 + 4);
    t87 = (t81 + 4);
    t88 = *((unsigned int *)t85);
    t89 = *((unsigned int *)t86);
    t90 = (t88 | t89);
    *((unsigned int *)t87) = t90;
    t91 = *((unsigned int *)t87);
    t92 = (t91 != 0);
    if (t92 == 1)
        goto LAB167;

LAB168:
LAB169:    goto LAB158;

LAB161:    t72 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t72) = 1;
    goto LAB162;

LAB163:    *((unsigned int *)t73) = 1;
    goto LAB166;

LAB165:    t80 = (t73 + 4);
    *((unsigned int *)t73) = 1;
    *((unsigned int *)t80) = 1;
    goto LAB166;

LAB167:    t93 = *((unsigned int *)t81);
    t94 = *((unsigned int *)t87);
    *((unsigned int *)t81) = (t93 | t94);
    t95 = (t33 + 4);
    t96 = (t73 + 4);
    t97 = *((unsigned int *)t33);
    t98 = (~(t97));
    t99 = *((unsigned int *)t95);
    t100 = (~(t99));
    t101 = *((unsigned int *)t73);
    t102 = (~(t101));
    t103 = *((unsigned int *)t96);
    t104 = (~(t103));
    t6 = (t98 & t100);
    t105 = (t102 & t104);
    t106 = (~(t6));
    t107 = (~(t105));
    t108 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t108 & t106);
    t109 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t109 & t107);
    t110 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t110 & t106);
    t111 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t111 & t107);
    goto LAB169;

LAB170:    *((unsigned int *)t112) = 1;
    goto LAB173;

LAB172:    t119 = (t112 + 4);
    *((unsigned int *)t112) = 1;
    *((unsigned int *)t119) = 1;
    goto LAB173;

LAB174:    t124 = (t0 + 1768);
    t125 = (t124 + 56U);
    t126 = *((char **)t125);
    memset(t127, 0, 8);
    t128 = (t127 + 4);
    t129 = (t126 + 8);
    t130 = (t126 + 12);
    t131 = *((unsigned int *)t129);
    t132 = (t131 >> 31);
    t133 = (t132 & 1);
    *((unsigned int *)t127) = t133;
    t134 = *((unsigned int *)t130);
    t135 = (t134 >> 31);
    t136 = (t135 & 1);
    *((unsigned int *)t128) = t136;
    t137 = ((char*)((ng2)));
    memset(t138, 0, 8);
    t139 = (t127 + 4);
    t140 = (t137 + 4);
    t141 = *((unsigned int *)t127);
    t142 = *((unsigned int *)t137);
    t143 = (t141 ^ t142);
    t144 = *((unsigned int *)t139);
    t145 = *((unsigned int *)t140);
    t146 = (t144 ^ t145);
    t147 = (t143 | t146);
    t148 = *((unsigned int *)t139);
    t149 = *((unsigned int *)t140);
    t150 = (t148 | t149);
    t151 = (~(t150));
    t152 = (t147 & t151);
    if (t152 != 0)
        goto LAB180;

LAB177:    if (t150 != 0)
        goto LAB179;

LAB178:    *((unsigned int *)t138) = 1;

LAB180:    memset(t154, 0, 8);
    t155 = (t138 + 4);
    t156 = *((unsigned int *)t155);
    t157 = (~(t156));
    t158 = *((unsigned int *)t138);
    t159 = (t158 & t157);
    t160 = (t159 & 1U);
    if (t160 != 0)
        goto LAB181;

LAB182:    if (*((unsigned int *)t155) != 0)
        goto LAB183;

LAB184:    t163 = *((unsigned int *)t112);
    t164 = *((unsigned int *)t154);
    t165 = (t163 & t164);
    *((unsigned int *)t162) = t165;
    t166 = (t112 + 4);
    t167 = (t154 + 4);
    t168 = (t162 + 4);
    t169 = *((unsigned int *)t166);
    t170 = *((unsigned int *)t167);
    t171 = (t169 | t170);
    *((unsigned int *)t168) = t171;
    t172 = *((unsigned int *)t168);
    t173 = (t172 != 0);
    if (t173 == 1)
        goto LAB185;

LAB186:
LAB187:    goto LAB176;

LAB179:    t153 = (t138 + 4);
    *((unsigned int *)t138) = 1;
    *((unsigned int *)t153) = 1;
    goto LAB180;

LAB181:    *((unsigned int *)t154) = 1;
    goto LAB184;

LAB183:    t161 = (t154 + 4);
    *((unsigned int *)t154) = 1;
    *((unsigned int *)t161) = 1;
    goto LAB184;

LAB185:    t174 = *((unsigned int *)t162);
    t175 = *((unsigned int *)t168);
    *((unsigned int *)t162) = (t174 | t175);
    t176 = (t112 + 4);
    t177 = (t154 + 4);
    t178 = *((unsigned int *)t112);
    t179 = (~(t178));
    t180 = *((unsigned int *)t176);
    t181 = (~(t180));
    t182 = *((unsigned int *)t154);
    t183 = (~(t182));
    t184 = *((unsigned int *)t177);
    t185 = (~(t184));
    t186 = (t179 & t181);
    t187 = (t183 & t185);
    t188 = (~(t186));
    t189 = (~(t187));
    t190 = *((unsigned int *)t168);
    *((unsigned int *)t168) = (t190 & t188);
    t191 = *((unsigned int *)t168);
    *((unsigned int *)t168) = (t191 & t189);
    t192 = *((unsigned int *)t162);
    *((unsigned int *)t162) = (t192 & t188);
    t193 = *((unsigned int *)t162);
    *((unsigned int *)t162) = (t193 & t189);
    goto LAB187;

LAB188:    xsi_set_current_line(66, ng0);
    t200 = ((char*)((ng3)));
    t201 = (t0 + 2408);
    xsi_vlogvar_assign_value(t201, t200, 0, 0, 1);
    goto LAB190;

LAB193:    t32 = (t19 + 4);
    *((unsigned int *)t19) = 1;
    *((unsigned int *)t32) = 1;
    goto LAB194;

LAB195:    *((unsigned int *)t33) = 1;
    goto LAB198;

LAB197:    t40 = (t33 + 4);
    *((unsigned int *)t33) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB198;

LAB199:    t45 = (t0 + 1208U);
    t46 = *((char **)t45);
    memset(t47, 0, 8);
    t45 = (t47 + 4);
    t48 = (t46 + 8);
    t49 = (t46 + 12);
    t50 = *((unsigned int *)t48);
    t51 = (t50 >> 31);
    t52 = (t51 & 1);
    *((unsigned int *)t47) = t52;
    t53 = *((unsigned int *)t49);
    t54 = (t53 >> 31);
    t55 = (t54 & 1);
    *((unsigned int *)t45) = t55;
    t56 = ((char*)((ng1)));
    memset(t57, 0, 8);
    t58 = (t47 + 4);
    t59 = (t56 + 4);
    t60 = *((unsigned int *)t47);
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
        goto LAB205;

LAB202:    if (t69 != 0)
        goto LAB204;

LAB203:    *((unsigned int *)t57) = 1;

LAB205:    memset(t73, 0, 8);
    t74 = (t57 + 4);
    t75 = *((unsigned int *)t74);
    t76 = (~(t75));
    t77 = *((unsigned int *)t57);
    t78 = (t77 & t76);
    t79 = (t78 & 1U);
    if (t79 != 0)
        goto LAB206;

LAB207:    if (*((unsigned int *)t74) != 0)
        goto LAB208;

LAB209:    t82 = *((unsigned int *)t33);
    t83 = *((unsigned int *)t73);
    t84 = (t82 & t83);
    *((unsigned int *)t81) = t84;
    t85 = (t33 + 4);
    t86 = (t73 + 4);
    t87 = (t81 + 4);
    t88 = *((unsigned int *)t85);
    t89 = *((unsigned int *)t86);
    t90 = (t88 | t89);
    *((unsigned int *)t87) = t90;
    t91 = *((unsigned int *)t87);
    t92 = (t91 != 0);
    if (t92 == 1)
        goto LAB210;

LAB211:
LAB212:    goto LAB201;

LAB204:    t72 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t72) = 1;
    goto LAB205;

LAB206:    *((unsigned int *)t73) = 1;
    goto LAB209;

LAB208:    t80 = (t73 + 4);
    *((unsigned int *)t73) = 1;
    *((unsigned int *)t80) = 1;
    goto LAB209;

LAB210:    t93 = *((unsigned int *)t81);
    t94 = *((unsigned int *)t87);
    *((unsigned int *)t81) = (t93 | t94);
    t95 = (t33 + 4);
    t96 = (t73 + 4);
    t97 = *((unsigned int *)t33);
    t98 = (~(t97));
    t99 = *((unsigned int *)t95);
    t100 = (~(t99));
    t101 = *((unsigned int *)t73);
    t102 = (~(t101));
    t103 = *((unsigned int *)t96);
    t104 = (~(t103));
    t6 = (t98 & t100);
    t105 = (t102 & t104);
    t106 = (~(t6));
    t107 = (~(t105));
    t108 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t108 & t106);
    t109 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t109 & t107);
    t110 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t110 & t106);
    t111 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t111 & t107);
    goto LAB212;

LAB213:    *((unsigned int *)t112) = 1;
    goto LAB216;

LAB215:    t119 = (t112 + 4);
    *((unsigned int *)t112) = 1;
    *((unsigned int *)t119) = 1;
    goto LAB216;

LAB217:    t124 = (t0 + 1768);
    t125 = (t124 + 56U);
    t126 = *((char **)t125);
    memset(t127, 0, 8);
    t128 = (t127 + 4);
    t129 = (t126 + 8);
    t130 = (t126 + 12);
    t131 = *((unsigned int *)t129);
    t132 = (t131 >> 31);
    t133 = (t132 & 1);
    *((unsigned int *)t127) = t133;
    t134 = *((unsigned int *)t130);
    t135 = (t134 >> 31);
    t136 = (t135 & 1);
    *((unsigned int *)t128) = t136;
    t137 = ((char*)((ng1)));
    memset(t138, 0, 8);
    t139 = (t127 + 4);
    t140 = (t137 + 4);
    t141 = *((unsigned int *)t127);
    t142 = *((unsigned int *)t137);
    t143 = (t141 ^ t142);
    t144 = *((unsigned int *)t139);
    t145 = *((unsigned int *)t140);
    t146 = (t144 ^ t145);
    t147 = (t143 | t146);
    t148 = *((unsigned int *)t139);
    t149 = *((unsigned int *)t140);
    t150 = (t148 | t149);
    t151 = (~(t150));
    t152 = (t147 & t151);
    if (t152 != 0)
        goto LAB223;

LAB220:    if (t150 != 0)
        goto LAB222;

LAB221:    *((unsigned int *)t138) = 1;

LAB223:    memset(t154, 0, 8);
    t155 = (t138 + 4);
    t156 = *((unsigned int *)t155);
    t157 = (~(t156));
    t158 = *((unsigned int *)t138);
    t159 = (t158 & t157);
    t160 = (t159 & 1U);
    if (t160 != 0)
        goto LAB224;

LAB225:    if (*((unsigned int *)t155) != 0)
        goto LAB226;

LAB227:    t163 = *((unsigned int *)t112);
    t164 = *((unsigned int *)t154);
    t165 = (t163 & t164);
    *((unsigned int *)t162) = t165;
    t166 = (t112 + 4);
    t167 = (t154 + 4);
    t168 = (t162 + 4);
    t169 = *((unsigned int *)t166);
    t170 = *((unsigned int *)t167);
    t171 = (t169 | t170);
    *((unsigned int *)t168) = t171;
    t172 = *((unsigned int *)t168);
    t173 = (t172 != 0);
    if (t173 == 1)
        goto LAB228;

LAB229:
LAB230:    goto LAB219;

LAB222:    t153 = (t138 + 4);
    *((unsigned int *)t138) = 1;
    *((unsigned int *)t153) = 1;
    goto LAB223;

LAB224:    *((unsigned int *)t154) = 1;
    goto LAB227;

LAB226:    t161 = (t154 + 4);
    *((unsigned int *)t154) = 1;
    *((unsigned int *)t161) = 1;
    goto LAB227;

LAB228:    t174 = *((unsigned int *)t162);
    t175 = *((unsigned int *)t168);
    *((unsigned int *)t162) = (t174 | t175);
    t176 = (t112 + 4);
    t177 = (t154 + 4);
    t178 = *((unsigned int *)t112);
    t179 = (~(t178));
    t180 = *((unsigned int *)t176);
    t181 = (~(t180));
    t182 = *((unsigned int *)t154);
    t183 = (~(t182));
    t184 = *((unsigned int *)t177);
    t185 = (~(t184));
    t186 = (t179 & t181);
    t187 = (t183 & t185);
    t188 = (~(t186));
    t189 = (~(t187));
    t190 = *((unsigned int *)t168);
    *((unsigned int *)t168) = (t190 & t188);
    t191 = *((unsigned int *)t168);
    *((unsigned int *)t168) = (t191 & t189);
    t192 = *((unsigned int *)t162);
    *((unsigned int *)t162) = (t192 & t188);
    t193 = *((unsigned int *)t162);
    *((unsigned int *)t162) = (t193 & t189);
    goto LAB230;

LAB231:    xsi_set_current_line(69, ng0);
    t200 = ((char*)((ng3)));
    t201 = (t0 + 2408);
    xsi_vlogvar_assign_value(t201, t200, 0, 0, 1);
    goto LAB233;

LAB236:    xsi_set_current_line(76, ng0);

LAB245:    xsi_set_current_line(77, ng0);
    t41 = (t0 + 1208U);
    t45 = *((char **)t41);
    t41 = ((char*)((ng6)));
    xsi_vlogtype_concat(t202, 128, 128, 2U, t41, 64, t45, 64);
    t46 = (t0 + 3048);
    xsi_vlogvar_assign_value(t46, t202, 0, 0, 128);
    xsi_set_current_line(78, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = (t0 + 2888);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 64);
    xsi_set_current_line(79, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t13 = *((unsigned int *)t3);
    t14 = (~(t13));
    t15 = *((unsigned int *)t2);
    t6 = (t15 & t14);
    t4 = (t0 + 7252);
    *((int *)t4) = t6;

LAB246:    t7 = (t0 + 7252);
    if (*((int *)t7) > 0)
        goto LAB247;

LAB248:    xsi_set_current_line(91, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 63, 0);
    t7 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t7, 1, t203, 64);
    t8 = (t0 + 1768);
    xsi_vlogvar_assign_value(t8, t10, 0, 0, 64);
    t9 = (t0 + 2248);
    xsi_vlogvar_assign_value(t9, t10, 64, 0, 1);
    goto LAB244;

LAB238:    xsi_set_current_line(95, ng0);

LAB261:    xsi_set_current_line(97, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    xsi_vlogtype_unsigned_bit_neg(t203, 64, t4, 64);
    t3 = ((char*)((ng9)));
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t3, 64);
    t7 = ((char*)((ng6)));
    xsi_vlogtype_concat(t202, 128, 128, 2U, t7, 64, t204, 64);
    t8 = (t0 + 3048);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    xsi_set_current_line(98, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = (t0 + 2888);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 64);
    xsi_set_current_line(99, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t13 = *((unsigned int *)t3);
    t14 = (~(t13));
    t15 = *((unsigned int *)t2);
    t6 = (t15 & t14);
    t4 = (t0 + 7256);
    *((int *)t4) = t6;

LAB262:    t7 = (t0 + 7256);
    if (*((int *)t7) > 0)
        goto LAB263;

LAB264:    xsi_set_current_line(113, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_unsigned_unary_minus(t202, 128, t4, 128);
    t7 = (t0 + 3048);
    xsi_vlogvar_assign_value(t7, t202, 0, 0, 128);
    xsi_set_current_line(114, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 63, 0);
    t7 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t7, 1, t203, 64);
    t8 = (t0 + 1768);
    xsi_vlogvar_assign_value(t8, t10, 0, 0, 64);
    t9 = (t0 + 2248);
    xsi_vlogvar_assign_value(t9, t10, 64, 0, 1);
    goto LAB244;

LAB240:    xsi_set_current_line(119, ng0);

LAB277:    xsi_set_current_line(120, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    t3 = ((char*)((ng6)));
    xsi_vlogtype_concat(t202, 128, 128, 2U, t3, 64, t4, 64);
    t7 = (t0 + 3048);
    xsi_vlogvar_assign_value(t7, t202, 0, 0, 128);
    xsi_set_current_line(121, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    xsi_vlogtype_unsigned_bit_neg(t203, 64, t3, 64);
    t2 = ((char*)((ng9)));
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t2, 64);
    t4 = (t0 + 2888);
    xsi_vlogvar_assign_value(t4, t204, 0, 0, 64);
    xsi_set_current_line(122, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t13 = *((unsigned int *)t3);
    t14 = (~(t13));
    t15 = *((unsigned int *)t2);
    t6 = (t15 & t14);
    t4 = (t0 + 7260);
    *((int *)t4) = t6;

LAB278:    t7 = (t0 + 7260);
    if (*((int *)t7) > 0)
        goto LAB279;

LAB280:    xsi_set_current_line(135, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_unsigned_unary_minus(t202, 128, t4, 128);
    t7 = (t0 + 3048);
    xsi_vlogvar_assign_value(t7, t202, 0, 0, 128);
    xsi_set_current_line(136, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 63, 0);
    t7 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t7, 1, t203, 64);
    t8 = (t0 + 1768);
    xsi_vlogvar_assign_value(t8, t10, 0, 0, 64);
    t9 = (t0 + 2248);
    xsi_vlogvar_assign_value(t9, t10, 64, 0, 1);
    goto LAB244;

LAB242:    xsi_set_current_line(140, ng0);

LAB293:    xsi_set_current_line(141, ng0);
    t3 = (t0 + 1208U);
    t4 = *((char **)t3);
    xsi_vlog_unsigned_unary_minus(t203, 64, t4, 64);
    t3 = ((char*)((ng6)));
    xsi_vlogtype_concat(t202, 128, 128, 2U, t3, 64, t203, 64);
    t7 = (t0 + 3048);
    xsi_vlogvar_assign_value(t7, t202, 0, 0, 128);
    xsi_set_current_line(142, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    xsi_vlog_unsigned_unary_minus(t203, 64, t3, 64);
    t2 = (t0 + 2888);
    xsi_vlogvar_assign_value(t2, t203, 0, 0, 64);
    xsi_set_current_line(143, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t13 = *((unsigned int *)t3);
    t14 = (~(t13));
    t15 = *((unsigned int *)t2);
    t6 = (t15 & t14);
    t4 = (t0 + 7264);
    *((int *)t4) = t6;

LAB294:    t7 = (t0 + 7264);
    if (*((int *)t7) > 0)
        goto LAB295;

LAB296:    xsi_set_current_line(157, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 63, 0);
    t7 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t7, 1, t203, 64);
    t8 = (t0 + 1768);
    xsi_vlogvar_assign_value(t8, t10, 0, 0, 64);
    t9 = (t0 + 2248);
    xsi_vlogvar_assign_value(t9, t10, 64, 0, 1);
    goto LAB244;

LAB247:    xsi_set_current_line(80, ng0);

LAB249:    xsi_set_current_line(81, ng0);
    t8 = (t0 + 3048);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    memset(t19, 0, 8);
    t32 = (t19 + 4);
    t34 = (t11 + 4);
    t16 = *((unsigned int *)t11);
    t17 = (t16 >> 0);
    t18 = (t17 & 1);
    *((unsigned int *)t19) = t18;
    t20 = *((unsigned int *)t34);
    t21 = (t20 >> 0);
    t22 = (t21 & 1);
    *((unsigned int *)t32) = t22;
    t40 = ((char*)((ng2)));
    memset(t33, 0, 8);
    t41 = (t19 + 4);
    t45 = (t40 + 4);
    t23 = *((unsigned int *)t19);
    t24 = *((unsigned int *)t40);
    t25 = (t23 ^ t24);
    t26 = *((unsigned int *)t41);
    t27 = *((unsigned int *)t45);
    t28 = (t26 ^ t27);
    t29 = (t25 | t28);
    t30 = *((unsigned int *)t41);
    t31 = *((unsigned int *)t45);
    t35 = (t30 | t31);
    t36 = (~(t35));
    t37 = (t29 & t36);
    if (t37 != 0)
        goto LAB253;

LAB250:    if (t35 != 0)
        goto LAB252;

LAB251:    *((unsigned int *)t33) = 1;

LAB253:    t48 = (t33 + 4);
    t38 = *((unsigned int *)t48);
    t39 = (~(t38));
    t42 = *((unsigned int *)t33);
    t43 = (t42 & t39);
    t44 = (t43 != 0);
    if (t44 > 0)
        goto LAB254;

LAB255:    xsi_set_current_line(87, ng0);

LAB260:    xsi_set_current_line(88, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3048);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);

LAB256:    t2 = (t0 + 7252);
    t6 = *((int *)t2);
    *((int *)t2) = (t6 - 1);
    goto LAB246;

LAB252:    t46 = (t33 + 4);
    *((unsigned int *)t33) = 1;
    *((unsigned int *)t46) = 1;
    goto LAB253;

LAB254:    xsi_set_current_line(82, ng0);

LAB257:    xsi_set_current_line(83, ng0);
    t49 = (t0 + 3048);
    t56 = (t49 + 56U);
    t58 = *((char **)t56);
    xsi_vlog_get_part_select_value(t203, 64, t58, 127, 64);
    t59 = (t0 + 2888);
    t72 = (t59 + 56U);
    t74 = *((char **)t72);
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t74, 64);
    t80 = (t0 + 3048);
    t85 = (t0 + 3048);
    t86 = (t85 + 72U);
    t87 = *((char **)t86);
    t95 = ((char*)((ng8)));
    t96 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t47, t57, t73, ((int*)(t87)), 2, t95, 32, 1, t96, 32, 1);
    t113 = (t47 + 4);
    t50 = *((unsigned int *)t113);
    t105 = (!(t50));
    t119 = (t57 + 4);
    t51 = *((unsigned int *)t119);
    t186 = (!(t51));
    t187 = (t105 && t186);
    t120 = (t73 + 4);
    t52 = *((unsigned int *)t120);
    t205 = (!(t52));
    t206 = (t187 && t205);
    if (t206 == 1)
        goto LAB258;

LAB259:    xsi_set_current_line(84, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3048);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    goto LAB256;

LAB258:    t53 = *((unsigned int *)t73);
    t207 = (t53 + 0);
    t54 = *((unsigned int *)t47);
    t55 = *((unsigned int *)t57);
    t208 = (t54 - t55);
    t209 = (t208 + 1);
    xsi_vlogvar_assign_value(t80, t204, t207, *((unsigned int *)t57), t209);
    goto LAB259;

LAB263:    xsi_set_current_line(100, ng0);

LAB265:    xsi_set_current_line(101, ng0);
    t8 = (t0 + 3048);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    memset(t19, 0, 8);
    t32 = (t19 + 4);
    t34 = (t11 + 4);
    t16 = *((unsigned int *)t11);
    t17 = (t16 >> 0);
    t18 = (t17 & 1);
    *((unsigned int *)t19) = t18;
    t20 = *((unsigned int *)t34);
    t21 = (t20 >> 0);
    t22 = (t21 & 1);
    *((unsigned int *)t32) = t22;
    t40 = ((char*)((ng2)));
    memset(t33, 0, 8);
    t41 = (t19 + 4);
    t45 = (t40 + 4);
    t23 = *((unsigned int *)t19);
    t24 = *((unsigned int *)t40);
    t25 = (t23 ^ t24);
    t26 = *((unsigned int *)t41);
    t27 = *((unsigned int *)t45);
    t28 = (t26 ^ t27);
    t29 = (t25 | t28);
    t30 = *((unsigned int *)t41);
    t31 = *((unsigned int *)t45);
    t35 = (t30 | t31);
    t36 = (~(t35));
    t37 = (t29 & t36);
    if (t37 != 0)
        goto LAB269;

LAB266:    if (t35 != 0)
        goto LAB268;

LAB267:    *((unsigned int *)t33) = 1;

LAB269:    t48 = (t33 + 4);
    t38 = *((unsigned int *)t48);
    t39 = (~(t38));
    t42 = *((unsigned int *)t33);
    t43 = (t42 & t39);
    t44 = (t43 != 0);
    if (t44 > 0)
        goto LAB270;

LAB271:    xsi_set_current_line(107, ng0);

LAB276:    xsi_set_current_line(108, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3048);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);

LAB272:    t2 = (t0 + 7256);
    t6 = *((int *)t2);
    *((int *)t2) = (t6 - 1);
    goto LAB262;

LAB268:    t46 = (t33 + 4);
    *((unsigned int *)t33) = 1;
    *((unsigned int *)t46) = 1;
    goto LAB269;

LAB270:    xsi_set_current_line(102, ng0);

LAB273:    xsi_set_current_line(103, ng0);
    t49 = (t0 + 3048);
    t56 = (t49 + 56U);
    t58 = *((char **)t56);
    xsi_vlog_get_part_select_value(t203, 64, t58, 127, 64);
    t59 = (t0 + 2888);
    t72 = (t59 + 56U);
    t74 = *((char **)t72);
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t74, 64);
    t80 = (t0 + 3048);
    t85 = (t0 + 3048);
    t86 = (t85 + 72U);
    t87 = *((char **)t86);
    t95 = ((char*)((ng8)));
    t96 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t47, t57, t73, ((int*)(t87)), 2, t95, 32, 1, t96, 32, 1);
    t113 = (t47 + 4);
    t50 = *((unsigned int *)t113);
    t105 = (!(t50));
    t119 = (t57 + 4);
    t51 = *((unsigned int *)t119);
    t186 = (!(t51));
    t187 = (t105 && t186);
    t120 = (t73 + 4);
    t52 = *((unsigned int *)t120);
    t205 = (!(t52));
    t206 = (t187 && t205);
    if (t206 == 1)
        goto LAB274;

LAB275:    xsi_set_current_line(104, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3048);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    goto LAB272;

LAB274:    t53 = *((unsigned int *)t73);
    t207 = (t53 + 0);
    t54 = *((unsigned int *)t47);
    t55 = *((unsigned int *)t57);
    t208 = (t54 - t55);
    t209 = (t208 + 1);
    xsi_vlogvar_assign_value(t80, t204, t207, *((unsigned int *)t57), t209);
    goto LAB275;

LAB279:    xsi_set_current_line(124, ng0);

LAB281:    xsi_set_current_line(125, ng0);
    t8 = (t0 + 3048);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    memset(t19, 0, 8);
    t32 = (t19 + 4);
    t34 = (t11 + 4);
    t16 = *((unsigned int *)t11);
    t17 = (t16 >> 0);
    t18 = (t17 & 1);
    *((unsigned int *)t19) = t18;
    t20 = *((unsigned int *)t34);
    t21 = (t20 >> 0);
    t22 = (t21 & 1);
    *((unsigned int *)t32) = t22;
    t40 = ((char*)((ng2)));
    memset(t33, 0, 8);
    t41 = (t19 + 4);
    t45 = (t40 + 4);
    t23 = *((unsigned int *)t19);
    t24 = *((unsigned int *)t40);
    t25 = (t23 ^ t24);
    t26 = *((unsigned int *)t41);
    t27 = *((unsigned int *)t45);
    t28 = (t26 ^ t27);
    t29 = (t25 | t28);
    t30 = *((unsigned int *)t41);
    t31 = *((unsigned int *)t45);
    t35 = (t30 | t31);
    t36 = (~(t35));
    t37 = (t29 & t36);
    if (t37 != 0)
        goto LAB285;

LAB282:    if (t35 != 0)
        goto LAB284;

LAB283:    *((unsigned int *)t33) = 1;

LAB285:    t48 = (t33 + 4);
    t38 = *((unsigned int *)t48);
    t39 = (~(t38));
    t42 = *((unsigned int *)t33);
    t43 = (t42 & t39);
    t44 = (t43 != 0);
    if (t44 > 0)
        goto LAB286;

LAB287:    xsi_set_current_line(131, ng0);

LAB292:    xsi_set_current_line(132, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3048);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);

LAB288:    t2 = (t0 + 7260);
    t6 = *((int *)t2);
    *((int *)t2) = (t6 - 1);
    goto LAB278;

LAB284:    t46 = (t33 + 4);
    *((unsigned int *)t33) = 1;
    *((unsigned int *)t46) = 1;
    goto LAB285;

LAB286:    xsi_set_current_line(126, ng0);

LAB289:    xsi_set_current_line(127, ng0);
    t49 = (t0 + 3048);
    t56 = (t49 + 56U);
    t58 = *((char **)t56);
    xsi_vlog_get_part_select_value(t203, 64, t58, 127, 64);
    t59 = (t0 + 2888);
    t72 = (t59 + 56U);
    t74 = *((char **)t72);
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t74, 64);
    t80 = (t0 + 3048);
    t85 = (t0 + 3048);
    t86 = (t85 + 72U);
    t87 = *((char **)t86);
    t95 = ((char*)((ng8)));
    t96 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t47, t57, t73, ((int*)(t87)), 2, t95, 32, 1, t96, 32, 1);
    t113 = (t47 + 4);
    t50 = *((unsigned int *)t113);
    t105 = (!(t50));
    t119 = (t57 + 4);
    t51 = *((unsigned int *)t119);
    t186 = (!(t51));
    t187 = (t105 && t186);
    t120 = (t73 + 4);
    t52 = *((unsigned int *)t120);
    t205 = (!(t52));
    t206 = (t187 && t205);
    if (t206 == 1)
        goto LAB290;

LAB291:    xsi_set_current_line(128, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3048);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    goto LAB288;

LAB290:    t53 = *((unsigned int *)t73);
    t207 = (t53 + 0);
    t54 = *((unsigned int *)t47);
    t55 = *((unsigned int *)t57);
    t208 = (t54 - t55);
    t209 = (t208 + 1);
    xsi_vlogvar_assign_value(t80, t204, t207, *((unsigned int *)t57), t209);
    goto LAB291;

LAB295:    xsi_set_current_line(144, ng0);

LAB297:    xsi_set_current_line(145, ng0);
    t8 = (t0 + 3048);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    memset(t19, 0, 8);
    t32 = (t19 + 4);
    t34 = (t11 + 4);
    t16 = *((unsigned int *)t11);
    t17 = (t16 >> 0);
    t18 = (t17 & 1);
    *((unsigned int *)t19) = t18;
    t20 = *((unsigned int *)t34);
    t21 = (t20 >> 0);
    t22 = (t21 & 1);
    *((unsigned int *)t32) = t22;
    t40 = ((char*)((ng2)));
    memset(t33, 0, 8);
    t41 = (t19 + 4);
    t45 = (t40 + 4);
    t23 = *((unsigned int *)t19);
    t24 = *((unsigned int *)t40);
    t25 = (t23 ^ t24);
    t26 = *((unsigned int *)t41);
    t27 = *((unsigned int *)t45);
    t28 = (t26 ^ t27);
    t29 = (t25 | t28);
    t30 = *((unsigned int *)t41);
    t31 = *((unsigned int *)t45);
    t35 = (t30 | t31);
    t36 = (~(t35));
    t37 = (t29 & t36);
    if (t37 != 0)
        goto LAB301;

LAB298:    if (t35 != 0)
        goto LAB300;

LAB299:    *((unsigned int *)t33) = 1;

LAB301:    t48 = (t33 + 4);
    t38 = *((unsigned int *)t48);
    t39 = (~(t38));
    t42 = *((unsigned int *)t33);
    t43 = (t42 & t39);
    t44 = (t43 != 0);
    if (t44 > 0)
        goto LAB302;

LAB303:    xsi_set_current_line(151, ng0);

LAB308:    xsi_set_current_line(152, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3048);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);

LAB304:    t2 = (t0 + 7264);
    t6 = *((int *)t2);
    *((int *)t2) = (t6 - 1);
    goto LAB294;

LAB300:    t46 = (t33 + 4);
    *((unsigned int *)t33) = 1;
    *((unsigned int *)t46) = 1;
    goto LAB301;

LAB302:    xsi_set_current_line(146, ng0);

LAB305:    xsi_set_current_line(147, ng0);
    t49 = (t0 + 3048);
    t56 = (t49 + 56U);
    t58 = *((char **)t56);
    xsi_vlog_get_part_select_value(t203, 64, t58, 127, 64);
    t59 = (t0 + 2888);
    t72 = (t59 + 56U);
    t74 = *((char **)t72);
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t74, 64);
    t80 = (t0 + 3048);
    t85 = (t0 + 3048);
    t86 = (t85 + 72U);
    t87 = *((char **)t86);
    t95 = ((char*)((ng8)));
    t96 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t47, t57, t73, ((int*)(t87)), 2, t95, 32, 1, t96, 32, 1);
    t113 = (t47 + 4);
    t50 = *((unsigned int *)t113);
    t105 = (!(t50));
    t119 = (t57 + 4);
    t51 = *((unsigned int *)t119);
    t186 = (!(t51));
    t187 = (t105 && t186);
    t120 = (t73 + 4);
    t52 = *((unsigned int *)t120);
    t205 = (!(t52));
    t206 = (t187 && t205);
    if (t206 == 1)
        goto LAB306;

LAB307:    xsi_set_current_line(148, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3048);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    goto LAB304;

LAB306:    t53 = *((unsigned int *)t73);
    t207 = (t53 + 0);
    t54 = *((unsigned int *)t47);
    t55 = *((unsigned int *)t57);
    t208 = (t54 - t55);
    t209 = (t208 + 1);
    xsi_vlogvar_assign_value(t80, t204, t207, *((unsigned int *)t57), t209);
    goto LAB307;

LAB310:    xsi_set_current_line(165, ng0);
    xsi_vlogfile_write(1, 0, 0, ng12, 1, t0);
    goto LAB312;

LAB315:    xsi_set_current_line(170, ng0);

LAB324:    xsi_set_current_line(171, ng0);
    t40 = (t0 + 1048U);
    t41 = *((char **)t40);
    t40 = ((char*)((ng6)));
    xsi_vlogtype_concat(t202, 128, 128, 2U, t40, 64, t41, 64);
    t45 = (t0 + 3368);
    xsi_vlogvar_assign_value(t45, t202, 0, 0, 128);
    xsi_set_current_line(172, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    t2 = (t0 + 3208);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 64);
    xsi_set_current_line(173, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3368);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    xsi_set_current_line(174, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t13 = *((unsigned int *)t3);
    t14 = (~(t13));
    t15 = *((unsigned int *)t2);
    t6 = (t15 & t14);
    t4 = (t0 + 7268);
    *((int *)t4) = t6;

LAB325:    t7 = (t0 + 7268);
    if (*((int *)t7) > 0)
        goto LAB326;

LAB327:    xsi_set_current_line(189, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 127, 64);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t204, 64, t203, 64, t7, 32);
    t8 = (t0 + 3368);
    t9 = (t0 + 3368);
    t11 = (t9 + 72U);
    t32 = *((char **)t11);
    t34 = ((char*)((ng8)));
    t40 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t33, t47, t57, ((int*)(t32)), 2, t34, 32, 1, t40, 32, 1);
    t41 = (t33 + 4);
    t13 = *((unsigned int *)t41);
    t6 = (!(t13));
    t45 = (t47 + 4);
    t14 = *((unsigned int *)t45);
    t105 = (!(t14));
    t186 = (t6 && t105);
    t46 = (t57 + 4);
    t15 = *((unsigned int *)t46);
    t187 = (!(t15));
    t205 = (t186 && t187);
    if (t205 == 1)
        goto LAB346;

LAB347:    xsi_set_current_line(190, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 63, 0);
    t7 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t7, 1, t203, 64);
    t8 = (t0 + 1768);
    xsi_vlogvar_assign_value(t8, t10, 0, 0, 64);
    t9 = (t0 + 2248);
    xsi_vlogvar_assign_value(t9, t10, 64, 0, 1);
    goto LAB323;

LAB317:    xsi_set_current_line(194, ng0);

LAB348:    xsi_set_current_line(195, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    t3 = ((char*)((ng6)));
    xsi_vlogtype_concat(t202, 128, 128, 2U, t3, 64, t4, 64);
    t7 = (t0 + 3368);
    xsi_vlogvar_assign_value(t7, t202, 0, 0, 128);
    xsi_set_current_line(196, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    xsi_vlogtype_unsigned_bit_neg(t203, 64, t3, 64);
    t2 = ((char*)((ng9)));
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t2, 64);
    t4 = (t0 + 3208);
    xsi_vlogvar_assign_value(t4, t204, 0, 0, 64);
    xsi_set_current_line(197, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3368);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    xsi_set_current_line(198, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t13 = *((unsigned int *)t3);
    t14 = (~(t13));
    t15 = *((unsigned int *)t2);
    t6 = (t15 & t14);
    t4 = (t0 + 7272);
    *((int *)t4) = t6;

LAB349:    t7 = (t0 + 7272);
    if (*((int *)t7) > 0)
        goto LAB350;

LAB351:    xsi_set_current_line(213, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 127, 64);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t204, 64, t203, 64, t7, 32);
    t8 = (t0 + 3368);
    t9 = (t0 + 3368);
    t11 = (t9 + 72U);
    t32 = *((char **)t11);
    t34 = ((char*)((ng8)));
    t40 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t33, t47, t57, ((int*)(t32)), 2, t34, 32, 1, t40, 32, 1);
    t41 = (t33 + 4);
    t13 = *((unsigned int *)t41);
    t6 = (!(t13));
    t45 = (t47 + 4);
    t14 = *((unsigned int *)t45);
    t105 = (!(t14));
    t186 = (t6 && t105);
    t46 = (t57 + 4);
    t15 = *((unsigned int *)t46);
    t187 = (!(t15));
    t205 = (t186 && t187);
    if (t205 == 1)
        goto LAB370;

LAB371:    xsi_set_current_line(214, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t204, 64, t4, 63, 0);
    xsi_vlogtype_unsigned_bit_neg(t203, 64, t204, 64);
    t7 = ((char*)((ng9)));
    xsi_vlog_unsigned_add(t210, 64, t203, 64, t7, 64);
    t8 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t8, 1, t210, 64);
    t9 = (t0 + 1768);
    xsi_vlogvar_assign_value(t9, t10, 0, 0, 64);
    t11 = (t0 + 2248);
    xsi_vlogvar_assign_value(t11, t10, 64, 0, 1);
    goto LAB323;

LAB319:    xsi_set_current_line(218, ng0);

LAB372:    xsi_set_current_line(219, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    xsi_vlogtype_unsigned_bit_neg(t203, 64, t4, 64);
    t3 = ((char*)((ng9)));
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t3, 64);
    t7 = ((char*)((ng6)));
    xsi_vlogtype_concat(t202, 128, 128, 2U, t7, 64, t204, 64);
    t8 = (t0 + 3368);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    xsi_set_current_line(220, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    t2 = (t0 + 3208);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 64);
    xsi_set_current_line(221, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3368);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    xsi_set_current_line(222, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t13 = *((unsigned int *)t3);
    t14 = (~(t13));
    t15 = *((unsigned int *)t2);
    t6 = (t15 & t14);
    t4 = (t0 + 7276);
    *((int *)t4) = t6;

LAB373:    t7 = (t0 + 7276);
    if (*((int *)t7) > 0)
        goto LAB374;

LAB375:    xsi_set_current_line(237, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 127, 64);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t204, 64, t203, 64, t7, 32);
    t8 = (t0 + 3368);
    t9 = (t0 + 3368);
    t11 = (t9 + 72U);
    t32 = *((char **)t11);
    t34 = ((char*)((ng8)));
    t40 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t33, t47, t57, ((int*)(t32)), 2, t34, 32, 1, t40, 32, 1);
    t41 = (t33 + 4);
    t13 = *((unsigned int *)t41);
    t6 = (!(t13));
    t45 = (t47 + 4);
    t14 = *((unsigned int *)t45);
    t105 = (!(t14));
    t186 = (t6 && t105);
    t46 = (t57 + 4);
    t15 = *((unsigned int *)t46);
    t187 = (!(t15));
    t205 = (t186 && t187);
    if (t205 == 1)
        goto LAB394;

LAB395:    xsi_set_current_line(238, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t204, 64, t4, 63, 0);
    xsi_vlogtype_unsigned_bit_neg(t203, 64, t204, 64);
    t7 = ((char*)((ng9)));
    xsi_vlog_unsigned_add(t210, 64, t203, 64, t7, 64);
    t8 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t8, 1, t210, 64);
    t9 = (t0 + 1768);
    xsi_vlogvar_assign_value(t9, t10, 0, 0, 64);
    t11 = (t0 + 2248);
    xsi_vlogvar_assign_value(t11, t10, 64, 0, 1);
    goto LAB323;

LAB321:    xsi_set_current_line(242, ng0);

LAB396:    xsi_set_current_line(243, ng0);
    t3 = (t0 + 1048U);
    t4 = *((char **)t3);
    xsi_vlogtype_unsigned_bit_neg(t203, 64, t4, 64);
    t3 = ((char*)((ng9)));
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t3, 64);
    t7 = ((char*)((ng6)));
    xsi_vlogtype_concat(t202, 128, 128, 2U, t7, 64, t204, 64);
    t8 = (t0 + 3368);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    xsi_set_current_line(244, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    xsi_vlogtype_unsigned_bit_neg(t203, 64, t3, 64);
    t2 = ((char*)((ng9)));
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t2, 64);
    t4 = (t0 + 3208);
    xsi_vlogvar_assign_value(t4, t204, 0, 0, 64);
    xsi_set_current_line(245, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3368);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    xsi_set_current_line(246, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t13 = *((unsigned int *)t3);
    t14 = (~(t13));
    t15 = *((unsigned int *)t2);
    t6 = (t15 & t14);
    t4 = (t0 + 7280);
    *((int *)t4) = t6;

LAB397:    t7 = (t0 + 7280);
    if (*((int *)t7) > 0)
        goto LAB398;

LAB399:    xsi_set_current_line(261, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 127, 64);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_rshift(t204, 64, t203, 64, t7, 32);
    t8 = (t0 + 3368);
    t9 = (t0 + 3368);
    t11 = (t9 + 72U);
    t32 = *((char **)t11);
    t34 = ((char*)((ng8)));
    t40 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t33, t47, t57, ((int*)(t32)), 2, t34, 32, 1, t40, 32, 1);
    t41 = (t33 + 4);
    t13 = *((unsigned int *)t41);
    t6 = (!(t13));
    t45 = (t47 + 4);
    t14 = *((unsigned int *)t45);
    t105 = (!(t14));
    t186 = (t6 && t105);
    t46 = (t57 + 4);
    t15 = *((unsigned int *)t46);
    t187 = (!(t15));
    t205 = (t186 && t187);
    if (t205 == 1)
        goto LAB418;

LAB419:    xsi_set_current_line(262, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 63, 0);
    t7 = ((char*)((ng1)));
    xsi_vlogtype_concat(t10, 65, 65, 2U, t7, 1, t203, 64);
    t8 = (t0 + 1768);
    xsi_vlogvar_assign_value(t8, t10, 0, 0, 64);
    t9 = (t0 + 2248);
    xsi_vlogvar_assign_value(t9, t10, 64, 0, 1);
    goto LAB323;

LAB326:    xsi_set_current_line(175, ng0);

LAB328:    xsi_set_current_line(176, ng0);
    t8 = (t0 + 3368);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    xsi_vlog_get_part_select_value(t203, 64, t11, 127, 64);
    t32 = (t0 + 3208);
    t34 = (t32 + 56U);
    t40 = *((char **)t34);
    xsi_vlog_unsigned_minus(t204, 64, t203, 64, t40, 64);
    t41 = (t0 + 3368);
    t45 = (t0 + 3368);
    t46 = (t45 + 72U);
    t48 = *((char **)t46);
    t49 = ((char*)((ng8)));
    t56 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t33, t47, t57, ((int*)(t48)), 2, t49, 32, 1, t56, 32, 1);
    t58 = (t33 + 4);
    t16 = *((unsigned int *)t58);
    t105 = (!(t16));
    t59 = (t47 + 4);
    t17 = *((unsigned int *)t59);
    t186 = (!(t17));
    t187 = (t105 && t186);
    t72 = (t57 + 4);
    t18 = *((unsigned int *)t72);
    t205 = (!(t18));
    t206 = (t187 && t205);
    if (t206 == 1)
        goto LAB329;

LAB330:    xsi_set_current_line(177, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t33, 0, 8);
    t7 = (t33 + 4);
    t8 = (t4 + 24);
    t9 = (t4 + 28);
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t9);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t7) = t18;
    t11 = ((char*)((ng1)));
    memset(t47, 0, 8);
    t32 = (t33 + 4);
    t34 = (t11 + 4);
    t20 = *((unsigned int *)t33);
    t21 = *((unsigned int *)t11);
    t22 = (t20 ^ t21);
    t23 = *((unsigned int *)t32);
    t24 = *((unsigned int *)t34);
    t25 = (t23 ^ t24);
    t26 = (t22 | t25);
    t27 = *((unsigned int *)t32);
    t28 = *((unsigned int *)t34);
    t29 = (t27 | t28);
    t30 = (~(t29));
    t31 = (t26 & t30);
    if (t31 != 0)
        goto LAB334;

LAB331:    if (t29 != 0)
        goto LAB333;

LAB332:    *((unsigned int *)t47) = 1;

LAB334:    t41 = (t47 + 4);
    t35 = *((unsigned int *)t41);
    t36 = (~(t35));
    t37 = *((unsigned int *)t47);
    t38 = (t37 & t36);
    t39 = (t38 != 0);
    if (t39 > 0)
        goto LAB335;

LAB336:    xsi_set_current_line(183, ng0);

LAB341:    xsi_set_current_line(184, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 127, 64);
    t7 = (t0 + 3208);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t9, 64);
    t11 = (t0 + 3368);
    t32 = (t0 + 3368);
    t34 = (t32 + 72U);
    t40 = *((char **)t34);
    t41 = ((char*)((ng8)));
    t45 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t33, t47, t57, ((int*)(t40)), 2, t41, 32, 1, t45, 32, 1);
    t46 = (t33 + 4);
    t13 = *((unsigned int *)t46);
    t6 = (!(t13));
    t48 = (t47 + 4);
    t14 = *((unsigned int *)t48);
    t105 = (!(t14));
    t186 = (t6 && t105);
    t49 = (t57 + 4);
    t15 = *((unsigned int *)t49);
    t187 = (!(t15));
    t205 = (t186 && t187);
    if (t205 == 1)
        goto LAB342;

LAB343:    xsi_set_current_line(185, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3368);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    xsi_set_current_line(186, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3368);
    t4 = (t0 + 3368);
    t7 = (t4 + 72U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng4)));
    xsi_vlog_generic_convert_bit_index(t33, t8, 2, t9, 32, 1);
    t11 = (t33 + 4);
    t13 = *((unsigned int *)t11);
    t6 = (!(t13));
    if (t6 == 1)
        goto LAB344;

LAB345:
LAB337:    t2 = (t0 + 7268);
    t6 = *((int *)t2);
    *((int *)t2) = (t6 - 1);
    goto LAB325;

LAB329:    t20 = *((unsigned int *)t57);
    t207 = (t20 + 0);
    t21 = *((unsigned int *)t33);
    t22 = *((unsigned int *)t47);
    t208 = (t21 - t22);
    t209 = (t208 + 1);
    xsi_vlogvar_assign_value(t41, t204, t207, *((unsigned int *)t47), t209);
    goto LAB330;

LAB333:    t40 = (t47 + 4);
    *((unsigned int *)t47) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB334;

LAB335:    xsi_set_current_line(178, ng0);

LAB338:    xsi_set_current_line(179, ng0);
    t45 = (t0 + 3368);
    t46 = (t45 + 56U);
    t48 = *((char **)t46);
    t49 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t202, 128, t48, 128, t49, 32);
    t56 = (t0 + 3368);
    xsi_vlogvar_assign_value(t56, t202, 0, 0, 128);
    xsi_set_current_line(180, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3368);
    t4 = (t0 + 3368);
    t7 = (t4 + 72U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng4)));
    xsi_vlog_generic_convert_bit_index(t33, t8, 2, t9, 32, 1);
    t11 = (t33 + 4);
    t13 = *((unsigned int *)t11);
    t6 = (!(t13));
    if (t6 == 1)
        goto LAB339;

LAB340:    goto LAB337;

LAB339:    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t33), 1);
    goto LAB340;

LAB342:    t16 = *((unsigned int *)t57);
    t206 = (t16 + 0);
    t17 = *((unsigned int *)t33);
    t18 = *((unsigned int *)t47);
    t207 = (t17 - t18);
    t208 = (t207 + 1);
    xsi_vlogvar_assign_value(t11, t204, t206, *((unsigned int *)t47), t208);
    goto LAB343;

LAB344:    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t33), 1);
    goto LAB345;

LAB346:    t16 = *((unsigned int *)t57);
    t206 = (t16 + 0);
    t17 = *((unsigned int *)t33);
    t18 = *((unsigned int *)t47);
    t207 = (t17 - t18);
    t208 = (t207 + 1);
    xsi_vlogvar_assign_value(t8, t204, t206, *((unsigned int *)t47), t208);
    goto LAB347;

LAB350:    xsi_set_current_line(199, ng0);

LAB352:    xsi_set_current_line(200, ng0);
    t8 = (t0 + 3368);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    xsi_vlog_get_part_select_value(t203, 64, t11, 127, 64);
    t32 = (t0 + 3208);
    t34 = (t32 + 56U);
    t40 = *((char **)t34);
    xsi_vlog_unsigned_minus(t204, 64, t203, 64, t40, 64);
    t41 = (t0 + 3368);
    t45 = (t0 + 3368);
    t46 = (t45 + 72U);
    t48 = *((char **)t46);
    t49 = ((char*)((ng8)));
    t56 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t33, t47, t57, ((int*)(t48)), 2, t49, 32, 1, t56, 32, 1);
    t58 = (t33 + 4);
    t16 = *((unsigned int *)t58);
    t105 = (!(t16));
    t59 = (t47 + 4);
    t17 = *((unsigned int *)t59);
    t186 = (!(t17));
    t187 = (t105 && t186);
    t72 = (t57 + 4);
    t18 = *((unsigned int *)t72);
    t205 = (!(t18));
    t206 = (t187 && t205);
    if (t206 == 1)
        goto LAB353;

LAB354:    xsi_set_current_line(201, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t33, 0, 8);
    t7 = (t33 + 4);
    t8 = (t4 + 24);
    t9 = (t4 + 28);
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t9);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t7) = t18;
    t11 = ((char*)((ng1)));
    memset(t47, 0, 8);
    t32 = (t33 + 4);
    t34 = (t11 + 4);
    t20 = *((unsigned int *)t33);
    t21 = *((unsigned int *)t11);
    t22 = (t20 ^ t21);
    t23 = *((unsigned int *)t32);
    t24 = *((unsigned int *)t34);
    t25 = (t23 ^ t24);
    t26 = (t22 | t25);
    t27 = *((unsigned int *)t32);
    t28 = *((unsigned int *)t34);
    t29 = (t27 | t28);
    t30 = (~(t29));
    t31 = (t26 & t30);
    if (t31 != 0)
        goto LAB358;

LAB355:    if (t29 != 0)
        goto LAB357;

LAB356:    *((unsigned int *)t47) = 1;

LAB358:    t41 = (t47 + 4);
    t35 = *((unsigned int *)t41);
    t36 = (~(t35));
    t37 = *((unsigned int *)t47);
    t38 = (t37 & t36);
    t39 = (t38 != 0);
    if (t39 > 0)
        goto LAB359;

LAB360:    xsi_set_current_line(207, ng0);

LAB365:    xsi_set_current_line(208, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 127, 64);
    t7 = (t0 + 3208);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t9, 64);
    t11 = (t0 + 3368);
    t32 = (t0 + 3368);
    t34 = (t32 + 72U);
    t40 = *((char **)t34);
    t41 = ((char*)((ng8)));
    t45 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t33, t47, t57, ((int*)(t40)), 2, t41, 32, 1, t45, 32, 1);
    t46 = (t33 + 4);
    t13 = *((unsigned int *)t46);
    t6 = (!(t13));
    t48 = (t47 + 4);
    t14 = *((unsigned int *)t48);
    t105 = (!(t14));
    t186 = (t6 && t105);
    t49 = (t57 + 4);
    t15 = *((unsigned int *)t49);
    t187 = (!(t15));
    t205 = (t186 && t187);
    if (t205 == 1)
        goto LAB366;

LAB367:    xsi_set_current_line(209, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3368);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    xsi_set_current_line(210, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3368);
    t4 = (t0 + 3368);
    t7 = (t4 + 72U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng4)));
    xsi_vlog_generic_convert_bit_index(t33, t8, 2, t9, 32, 1);
    t11 = (t33 + 4);
    t13 = *((unsigned int *)t11);
    t6 = (!(t13));
    if (t6 == 1)
        goto LAB368;

LAB369:
LAB361:    t2 = (t0 + 7272);
    t6 = *((int *)t2);
    *((int *)t2) = (t6 - 1);
    goto LAB349;

LAB353:    t20 = *((unsigned int *)t57);
    t207 = (t20 + 0);
    t21 = *((unsigned int *)t33);
    t22 = *((unsigned int *)t47);
    t208 = (t21 - t22);
    t209 = (t208 + 1);
    xsi_vlogvar_assign_value(t41, t204, t207, *((unsigned int *)t47), t209);
    goto LAB354;

LAB357:    t40 = (t47 + 4);
    *((unsigned int *)t47) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB358;

LAB359:    xsi_set_current_line(202, ng0);

LAB362:    xsi_set_current_line(203, ng0);
    t45 = (t0 + 3368);
    t46 = (t45 + 56U);
    t48 = *((char **)t46);
    t49 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t202, 128, t48, 128, t49, 32);
    t56 = (t0 + 3368);
    xsi_vlogvar_assign_value(t56, t202, 0, 0, 128);
    xsi_set_current_line(204, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3368);
    t4 = (t0 + 3368);
    t7 = (t4 + 72U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng4)));
    xsi_vlog_generic_convert_bit_index(t33, t8, 2, t9, 32, 1);
    t11 = (t33 + 4);
    t13 = *((unsigned int *)t11);
    t6 = (!(t13));
    if (t6 == 1)
        goto LAB363;

LAB364:    goto LAB361;

LAB363:    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t33), 1);
    goto LAB364;

LAB366:    t16 = *((unsigned int *)t57);
    t206 = (t16 + 0);
    t17 = *((unsigned int *)t33);
    t18 = *((unsigned int *)t47);
    t207 = (t17 - t18);
    t208 = (t207 + 1);
    xsi_vlogvar_assign_value(t11, t204, t206, *((unsigned int *)t47), t208);
    goto LAB367;

LAB368:    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t33), 1);
    goto LAB369;

LAB370:    t16 = *((unsigned int *)t57);
    t206 = (t16 + 0);
    t17 = *((unsigned int *)t33);
    t18 = *((unsigned int *)t47);
    t207 = (t17 - t18);
    t208 = (t207 + 1);
    xsi_vlogvar_assign_value(t8, t204, t206, *((unsigned int *)t47), t208);
    goto LAB371;

LAB374:    xsi_set_current_line(223, ng0);

LAB376:    xsi_set_current_line(224, ng0);
    t8 = (t0 + 3368);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    xsi_vlog_get_part_select_value(t203, 64, t11, 127, 64);
    t32 = (t0 + 3208);
    t34 = (t32 + 56U);
    t40 = *((char **)t34);
    xsi_vlog_unsigned_minus(t204, 64, t203, 64, t40, 64);
    t41 = (t0 + 3368);
    t45 = (t0 + 3368);
    t46 = (t45 + 72U);
    t48 = *((char **)t46);
    t49 = ((char*)((ng8)));
    t56 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t33, t47, t57, ((int*)(t48)), 2, t49, 32, 1, t56, 32, 1);
    t58 = (t33 + 4);
    t16 = *((unsigned int *)t58);
    t105 = (!(t16));
    t59 = (t47 + 4);
    t17 = *((unsigned int *)t59);
    t186 = (!(t17));
    t187 = (t105 && t186);
    t72 = (t57 + 4);
    t18 = *((unsigned int *)t72);
    t205 = (!(t18));
    t206 = (t187 && t205);
    if (t206 == 1)
        goto LAB377;

LAB378:    xsi_set_current_line(225, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t33, 0, 8);
    t7 = (t33 + 4);
    t8 = (t4 + 24);
    t9 = (t4 + 28);
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t9);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t7) = t18;
    t11 = ((char*)((ng1)));
    memset(t47, 0, 8);
    t32 = (t33 + 4);
    t34 = (t11 + 4);
    t20 = *((unsigned int *)t33);
    t21 = *((unsigned int *)t11);
    t22 = (t20 ^ t21);
    t23 = *((unsigned int *)t32);
    t24 = *((unsigned int *)t34);
    t25 = (t23 ^ t24);
    t26 = (t22 | t25);
    t27 = *((unsigned int *)t32);
    t28 = *((unsigned int *)t34);
    t29 = (t27 | t28);
    t30 = (~(t29));
    t31 = (t26 & t30);
    if (t31 != 0)
        goto LAB382;

LAB379:    if (t29 != 0)
        goto LAB381;

LAB380:    *((unsigned int *)t47) = 1;

LAB382:    t41 = (t47 + 4);
    t35 = *((unsigned int *)t41);
    t36 = (~(t35));
    t37 = *((unsigned int *)t47);
    t38 = (t37 & t36);
    t39 = (t38 != 0);
    if (t39 > 0)
        goto LAB383;

LAB384:    xsi_set_current_line(231, ng0);

LAB389:    xsi_set_current_line(232, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 127, 64);
    t7 = (t0 + 3208);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t9, 64);
    t11 = (t0 + 3368);
    t32 = (t0 + 3368);
    t34 = (t32 + 72U);
    t40 = *((char **)t34);
    t41 = ((char*)((ng8)));
    t45 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t33, t47, t57, ((int*)(t40)), 2, t41, 32, 1, t45, 32, 1);
    t46 = (t33 + 4);
    t13 = *((unsigned int *)t46);
    t6 = (!(t13));
    t48 = (t47 + 4);
    t14 = *((unsigned int *)t48);
    t105 = (!(t14));
    t186 = (t6 && t105);
    t49 = (t57 + 4);
    t15 = *((unsigned int *)t49);
    t187 = (!(t15));
    t205 = (t186 && t187);
    if (t205 == 1)
        goto LAB390;

LAB391:    xsi_set_current_line(233, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3368);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    xsi_set_current_line(234, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3368);
    t4 = (t0 + 3368);
    t7 = (t4 + 72U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng4)));
    xsi_vlog_generic_convert_bit_index(t33, t8, 2, t9, 32, 1);
    t11 = (t33 + 4);
    t13 = *((unsigned int *)t11);
    t6 = (!(t13));
    if (t6 == 1)
        goto LAB392;

LAB393:
LAB385:    t2 = (t0 + 7276);
    t6 = *((int *)t2);
    *((int *)t2) = (t6 - 1);
    goto LAB373;

LAB377:    t20 = *((unsigned int *)t57);
    t207 = (t20 + 0);
    t21 = *((unsigned int *)t33);
    t22 = *((unsigned int *)t47);
    t208 = (t21 - t22);
    t209 = (t208 + 1);
    xsi_vlogvar_assign_value(t41, t204, t207, *((unsigned int *)t47), t209);
    goto LAB378;

LAB381:    t40 = (t47 + 4);
    *((unsigned int *)t47) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB382;

LAB383:    xsi_set_current_line(226, ng0);

LAB386:    xsi_set_current_line(227, ng0);
    t45 = (t0 + 3368);
    t46 = (t45 + 56U);
    t48 = *((char **)t46);
    t49 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t202, 128, t48, 128, t49, 32);
    t56 = (t0 + 3368);
    xsi_vlogvar_assign_value(t56, t202, 0, 0, 128);
    xsi_set_current_line(228, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3368);
    t4 = (t0 + 3368);
    t7 = (t4 + 72U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng4)));
    xsi_vlog_generic_convert_bit_index(t33, t8, 2, t9, 32, 1);
    t11 = (t33 + 4);
    t13 = *((unsigned int *)t11);
    t6 = (!(t13));
    if (t6 == 1)
        goto LAB387;

LAB388:    goto LAB385;

LAB387:    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t33), 1);
    goto LAB388;

LAB390:    t16 = *((unsigned int *)t57);
    t206 = (t16 + 0);
    t17 = *((unsigned int *)t33);
    t18 = *((unsigned int *)t47);
    t207 = (t17 - t18);
    t208 = (t207 + 1);
    xsi_vlogvar_assign_value(t11, t204, t206, *((unsigned int *)t47), t208);
    goto LAB391;

LAB392:    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t33), 1);
    goto LAB393;

LAB394:    t16 = *((unsigned int *)t57);
    t206 = (t16 + 0);
    t17 = *((unsigned int *)t33);
    t18 = *((unsigned int *)t47);
    t207 = (t17 - t18);
    t208 = (t207 + 1);
    xsi_vlogvar_assign_value(t8, t204, t206, *((unsigned int *)t47), t208);
    goto LAB395;

LAB398:    xsi_set_current_line(247, ng0);

LAB400:    xsi_set_current_line(248, ng0);
    t8 = (t0 + 3368);
    t9 = (t8 + 56U);
    t11 = *((char **)t9);
    xsi_vlog_get_part_select_value(t203, 64, t11, 127, 64);
    t32 = (t0 + 3208);
    t34 = (t32 + 56U);
    t40 = *((char **)t34);
    xsi_vlog_unsigned_minus(t204, 64, t203, 64, t40, 64);
    t41 = (t0 + 3368);
    t45 = (t0 + 3368);
    t46 = (t45 + 72U);
    t48 = *((char **)t46);
    t49 = ((char*)((ng8)));
    t56 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t33, t47, t57, ((int*)(t48)), 2, t49, 32, 1, t56, 32, 1);
    t58 = (t33 + 4);
    t16 = *((unsigned int *)t58);
    t105 = (!(t16));
    t59 = (t47 + 4);
    t17 = *((unsigned int *)t59);
    t186 = (!(t17));
    t187 = (t105 && t186);
    t72 = (t57 + 4);
    t18 = *((unsigned int *)t72);
    t205 = (!(t18));
    t206 = (t187 && t205);
    if (t206 == 1)
        goto LAB401;

LAB402:    xsi_set_current_line(249, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t33, 0, 8);
    t7 = (t33 + 4);
    t8 = (t4 + 24);
    t9 = (t4 + 28);
    t13 = *((unsigned int *)t8);
    t14 = (t13 >> 31);
    t15 = (t14 & 1);
    *((unsigned int *)t33) = t15;
    t16 = *((unsigned int *)t9);
    t17 = (t16 >> 31);
    t18 = (t17 & 1);
    *((unsigned int *)t7) = t18;
    t11 = ((char*)((ng1)));
    memset(t47, 0, 8);
    t32 = (t33 + 4);
    t34 = (t11 + 4);
    t20 = *((unsigned int *)t33);
    t21 = *((unsigned int *)t11);
    t22 = (t20 ^ t21);
    t23 = *((unsigned int *)t32);
    t24 = *((unsigned int *)t34);
    t25 = (t23 ^ t24);
    t26 = (t22 | t25);
    t27 = *((unsigned int *)t32);
    t28 = *((unsigned int *)t34);
    t29 = (t27 | t28);
    t30 = (~(t29));
    t31 = (t26 & t30);
    if (t31 != 0)
        goto LAB406;

LAB403:    if (t29 != 0)
        goto LAB405;

LAB404:    *((unsigned int *)t47) = 1;

LAB406:    t41 = (t47 + 4);
    t35 = *((unsigned int *)t41);
    t36 = (~(t35));
    t37 = *((unsigned int *)t47);
    t38 = (t37 & t36);
    t39 = (t38 != 0);
    if (t39 > 0)
        goto LAB407;

LAB408:    xsi_set_current_line(255, ng0);

LAB413:    xsi_set_current_line(256, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t203, 64, t4, 127, 64);
    t7 = (t0 + 3208);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    xsi_vlog_unsigned_add(t204, 64, t203, 64, t9, 64);
    t11 = (t0 + 3368);
    t32 = (t0 + 3368);
    t34 = (t32 + 72U);
    t40 = *((char **)t34);
    t41 = ((char*)((ng8)));
    t45 = ((char*)((ng7)));
    xsi_vlog_convert_partindices(t33, t47, t57, ((int*)(t40)), 2, t41, 32, 1, t45, 32, 1);
    t46 = (t33 + 4);
    t13 = *((unsigned int *)t46);
    t6 = (!(t13));
    t48 = (t47 + 4);
    t14 = *((unsigned int *)t48);
    t105 = (!(t14));
    t186 = (t6 && t105);
    t49 = (t57 + 4);
    t15 = *((unsigned int *)t49);
    t187 = (!(t15));
    t205 = (t186 && t187);
    if (t205 == 1)
        goto LAB414;

LAB415:    xsi_set_current_line(257, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t7 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t202, 128, t4, 128, t7, 32);
    t8 = (t0 + 3368);
    xsi_vlogvar_assign_value(t8, t202, 0, 0, 128);
    xsi_set_current_line(258, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3368);
    t4 = (t0 + 3368);
    t7 = (t4 + 72U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng4)));
    xsi_vlog_generic_convert_bit_index(t33, t8, 2, t9, 32, 1);
    t11 = (t33 + 4);
    t13 = *((unsigned int *)t11);
    t6 = (!(t13));
    if (t6 == 1)
        goto LAB416;

LAB417:
LAB409:    t2 = (t0 + 7280);
    t6 = *((int *)t2);
    *((int *)t2) = (t6 - 1);
    goto LAB397;

LAB401:    t20 = *((unsigned int *)t57);
    t207 = (t20 + 0);
    t21 = *((unsigned int *)t33);
    t22 = *((unsigned int *)t47);
    t208 = (t21 - t22);
    t209 = (t208 + 1);
    xsi_vlogvar_assign_value(t41, t204, t207, *((unsigned int *)t47), t209);
    goto LAB402;

LAB405:    t40 = (t47 + 4);
    *((unsigned int *)t47) = 1;
    *((unsigned int *)t40) = 1;
    goto LAB406;

LAB407:    xsi_set_current_line(250, ng0);

LAB410:    xsi_set_current_line(251, ng0);
    t45 = (t0 + 3368);
    t46 = (t45 + 56U);
    t48 = *((char **)t46);
    t49 = ((char*)((ng3)));
    xsi_vlog_unsigned_lshift(t202, 128, t48, 128, t49, 32);
    t56 = (t0 + 3368);
    xsi_vlogvar_assign_value(t56, t202, 0, 0, 128);
    xsi_set_current_line(252, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3368);
    t4 = (t0 + 3368);
    t7 = (t4 + 72U);
    t8 = *((char **)t7);
    t9 = ((char*)((ng4)));
    xsi_vlog_generic_convert_bit_index(t33, t8, 2, t9, 32, 1);
    t11 = (t33 + 4);
    t13 = *((unsigned int *)t11);
    t6 = (!(t13));
    if (t6 == 1)
        goto LAB411;

LAB412:    goto LAB409;

LAB411:    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t33), 1);
    goto LAB412;

LAB414:    t16 = *((unsigned int *)t57);
    t206 = (t16 + 0);
    t17 = *((unsigned int *)t33);
    t18 = *((unsigned int *)t47);
    t207 = (t17 - t18);
    t208 = (t207 + 1);
    xsi_vlogvar_assign_value(t11, t204, t206, *((unsigned int *)t47), t208);
    goto LAB415;

LAB416:    xsi_vlogvar_assign_value(t3, t2, 0, *((unsigned int *)t33), 1);
    goto LAB417;

LAB418:    t16 = *((unsigned int *)t57);
    t206 = (t16 + 0);
    t17 = *((unsigned int *)t33);
    t18 = *((unsigned int *)t47);
    t207 = (t17 - t18);
    t208 = (t207 + 1);
    xsi_vlogvar_assign_value(t8, t204, t206, *((unsigned int *)t47), t208);
    goto LAB419;

LAB422:    *((unsigned int *)t57) = 1;
    goto LAB424;

LAB423:    t46 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t46) = 1;
    goto LAB424;

LAB425:    xsi_set_current_line(273, ng0);
    t49 = ((char*)((ng3)));
    t56 = (t0 + 2408);
    xsi_vlogvar_assign_value(t56, t49, 0, 0, 1);
    goto LAB427;

LAB430:    *((unsigned int *)t57) = 1;
    goto LAB432;

LAB431:    t46 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t46) = 1;
    goto LAB432;

LAB433:    xsi_set_current_line(285, ng0);
    t49 = ((char*)((ng3)));
    t56 = (t0 + 2408);
    xsi_vlogvar_assign_value(t56, t49, 0, 0, 1);
    goto LAB435;

LAB436:    t29 = (t13 * 8);
    t30 = *((unsigned int *)t9);
    t31 = *((unsigned int *)t34);
    *((unsigned int *)t9) = (t30 | t31);
    t40 = (t4 + t29);
    t35 = (t29 + 4);
    t41 = (t4 + t35);
    t45 = (t7 + t29);
    t36 = (t29 + 4);
    t46 = (t7 + t36);
    t37 = *((unsigned int *)t40);
    t38 = (~(t37));
    t39 = *((unsigned int *)t41);
    t42 = (~(t39));
    t43 = *((unsigned int *)t45);
    t44 = (~(t43));
    t50 = *((unsigned int *)t46);
    t51 = (~(t50));
    t105 = (t38 & t42);
    t186 = (t44 & t51);
    t52 = (~(t105));
    t53 = (~(t186));
    t54 = *((unsigned int *)t34);
    *((unsigned int *)t34) = (t54 & t52);
    t55 = *((unsigned int *)t34);
    *((unsigned int *)t34) = (t55 & t53);
    t60 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t60 & t52);
    t61 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t61 & t53);

LAB438:    t13 = (t13 + 1);
    goto LAB439;

LAB437:    goto LAB438;

LAB440:    t15 = (t13 * 8);
    t3 = (t4 + t15);
    t8 = (t7 + t15);
    t9 = (t203 + t15);
    t16 = *((unsigned int *)t3);
    t17 = *((unsigned int *)t8);
    t18 = (t16 & t17);
    *((unsigned int *)t9) = t18;
    t20 = (t13 * 8);
    t21 = (t20 + 4);
    t11 = (t4 + t21);
    t22 = (t20 + 4);
    t32 = (t7 + t22);
    t23 = (t20 + 4);
    t34 = (t203 + t23);
    t24 = *((unsigned int *)t11);
    t25 = *((unsigned int *)t32);
    t26 = (t24 | t25);
    *((unsigned int *)t34) = t26;
    t27 = *((unsigned int *)t34);
    t28 = (t27 != 0);
    if (t28 == 1)
        goto LAB436;
    else
        goto LAB437;

LAB442:    t29 = (t13 * 8);
    t30 = *((unsigned int *)t9);
    t31 = *((unsigned int *)t34);
    *((unsigned int *)t9) = (t30 | t31);
    t40 = (t4 + t29);
    t35 = (t29 + 4);
    t41 = (t4 + t35);
    t45 = (t7 + t29);
    t36 = (t29 + 4);
    t46 = (t7 + t36);
    t37 = *((unsigned int *)t41);
    t38 = (~(t37));
    t39 = *((unsigned int *)t40);
    t105 = (t39 & t38);
    t42 = *((unsigned int *)t46);
    t43 = (~(t42));
    t44 = *((unsigned int *)t45);
    t186 = (t44 & t43);
    t50 = (~(t105));
    t51 = (~(t186));
    t52 = *((unsigned int *)t34);
    *((unsigned int *)t34) = (t52 & t50);
    t53 = *((unsigned int *)t34);
    *((unsigned int *)t34) = (t53 & t51);

LAB444:    t13 = (t13 + 1);
    goto LAB445;

LAB443:    goto LAB444;

LAB446:    t15 = (t13 * 8);
    t3 = (t4 + t15);
    t8 = (t7 + t15);
    t9 = (t203 + t15);
    t16 = *((unsigned int *)t3);
    t17 = *((unsigned int *)t8);
    t18 = (t16 | t17);
    *((unsigned int *)t9) = t18;
    t20 = (t13 * 8);
    t21 = (t20 + 4);
    t11 = (t4 + t21);
    t22 = (t20 + 4);
    t32 = (t7 + t22);
    t23 = (t20 + 4);
    t34 = (t203 + t23);
    t24 = *((unsigned int *)t11);
    t25 = *((unsigned int *)t32);
    t26 = (t24 | t25);
    *((unsigned int *)t34) = t26;
    t27 = *((unsigned int *)t34);
    t28 = (t27 != 0);
    if (t28 == 1)
        goto LAB442;
    else
        goto LAB443;

LAB448:    t29 = *((unsigned int *)t9);
    t30 = *((unsigned int *)t34);
    *((unsigned int *)t9) = (t29 | t30);

LAB450:    t13 = (t13 + 1);
    goto LAB451;

LAB449:    goto LAB450;

LAB452:    t15 = (t13 * 8);
    t3 = (t4 + t15);
    t8 = (t7 + t15);
    t9 = (t203 + t15);
    t16 = *((unsigned int *)t3);
    t17 = *((unsigned int *)t8);
    t18 = (t16 ^ t17);
    *((unsigned int *)t9) = t18;
    t20 = (t13 * 8);
    t21 = (t20 + 4);
    t11 = (t4 + t21);
    t22 = (t20 + 4);
    t32 = (t7 + t22);
    t23 = (t20 + 4);
    t34 = (t203 + t23);
    t24 = *((unsigned int *)t11);
    t25 = *((unsigned int *)t32);
    t26 = (t24 | t25);
    *((unsigned int *)t34) = t26;
    t27 = *((unsigned int *)t34);
    t28 = (t27 != 0);
    if (t28 == 1)
        goto LAB448;
    else
        goto LAB449;

LAB458:    *((unsigned int *)t57) = 1;
    goto LAB460;

LAB459:    t46 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t46) = 1;
    goto LAB460;

LAB461:    xsi_set_current_line(318, ng0);
    t49 = ((char*)((ng3)));
    t56 = (t0 + 2408);
    xsi_vlogvar_assign_value(t56, t49, 0, 0, 1);
    goto LAB463;

LAB464:    xsi_set_current_line(331, ng0);
    t9 = ((char*)((ng2)));
    t11 = (t0 + 2088);
    xsi_vlogvar_assign_value(t11, t9, 0, 0, 1);
    goto LAB466;

}


extern void work_m_00000000003495868339_2725559894_init()
{
	static char *pe[] = {(void *)Initial_36_0,(void *)Always_44_1};
	xsi_register_didat("work_m_00000000003495868339_2725559894", "isim/TB_isim_beh.exe.sim/work/m_00000000003495868339_2725559894.didat");
	xsi_register_executes(pe);
}
