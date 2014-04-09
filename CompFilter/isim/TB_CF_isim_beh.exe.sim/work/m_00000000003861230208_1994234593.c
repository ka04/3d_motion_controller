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

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/YangTianyu/Desktop/EC551/CompFilter/CF.v";
static int ng1[] = {0, 0};
static int ng2[] = {6, 0};
static unsigned int ng3[] = {45U, 0U};
static unsigned int ng4[] = {126U, 0U};
static int ng5[] = {5, 0};
static unsigned int ng6[] = {16U, 0U};
static int ng7[] = {10, 0};



static void Always_38_0(char *t0)
{
    char t4[8];
    char t21[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    char *t20;

LAB0:    t1 = (t0 + 3488U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 4056);
    *((int *)t2) = 1;
    t3 = (t0 + 3520);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(38, ng0);

LAB5:    xsi_set_current_line(39, ng0);
    t5 = (t0 + 1688U);
    t6 = *((char **)t5);
    memset(t4, 0, 8);
    t5 = (t6 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (~(t7));
    t9 = *((unsigned int *)t6);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB9;

LAB7:    if (*((unsigned int *)t5) == 0)
        goto LAB6;

LAB8:    t12 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t12) = 1;

LAB9:    t13 = (t4 + 4);
    t14 = *((unsigned int *)t13);
    t15 = (~(t14));
    t16 = *((unsigned int *)t4);
    t17 = (t16 & t15);
    t18 = (t17 != 0);
    if (t18 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(42, ng0);
    t2 = (t0 + 2568);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = (t0 + 1048U);
    t12 = *((char **)t6);
    t6 = ((char*)((ng2)));
    memset(t4, 0, 8);
    xsi_vlog_unsigned_arith_rshift(t4, 16, t12, 16, t6, 32);
    memset(t21, 0, 8);
    xsi_vlog_unsigned_add(t21, 16, t5, 16, t4, 16);
    t13 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t13, t21, 0, 0, 16, 0LL);

LAB12:    goto LAB2;

LAB6:    *((unsigned int *)t4) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(39, ng0);

LAB13:    xsi_set_current_line(40, ng0);
    t19 = ((char*)((ng1)));
    t20 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t20, t19, 0, 0, 16, 0LL);
    goto LAB12;

}

static void Always_55_1(char *t0)
{
    char t4[8];
    char t15[8];
    char t17[8];
    char t20[8];
    char t22[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t16;
    char *t18;
    char *t19;
    char *t21;
    char *t23;

LAB0:    t1 = (t0 + 3736U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(55, ng0);
    t2 = (t0 + 4072);
    *((int *)t2) = 1;
    t3 = (t0 + 3768);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(55, ng0);

LAB5:    xsi_set_current_line(56, ng0);
    t5 = (t0 + 1848U);
    t6 = *((char **)t5);
    memset(t4, 0, 8);
    t5 = (t4 + 4);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t6);
    t9 = (t8 >> 8);
    *((unsigned int *)t4) = t9;
    t10 = *((unsigned int *)t7);
    t11 = (t10 >> 8);
    *((unsigned int *)t5) = t11;
    t12 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t12 & 63U);
    t13 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t13 & 63U);
    t14 = ((char*)((ng3)));
    memset(t15, 0, 8);
    xsi_vlog_unsigned_multiply(t15, 16, t4, 16, t14, 16);
    t16 = ((char*)((ng2)));
    memset(t17, 0, 8);
    xsi_vlog_unsigned_rshift(t17, 16, t15, 16, t16, 32);
    t18 = (t0 + 2248);
    xsi_vlogvar_assign_value(t18, t17, 0, 0, 16);
    xsi_set_current_line(57, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 2568);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    memset(t4, 0, 8);
    xsi_vlog_unsigned_multiply(t4, 32, t2, 32, t6, 16);
    t7 = ((char*)((ng5)));
    t14 = ((char*)((ng6)));
    t16 = (t0 + 2248);
    t18 = (t16 + 56U);
    t19 = *((char **)t18);
    memset(t15, 0, 8);
    xsi_vlog_unsigned_multiply(t15, 32, t14, 32, t19, 16);
    memset(t17, 0, 8);
    xsi_vlog_unsigned_add(t17, 32, t7, 32, t15, 32);
    memset(t20, 0, 8);
    xsi_vlog_unsigned_rshift(t20, 32, t4, 32, t17, 32);
    t21 = ((char*)((ng7)));
    memset(t22, 0, 8);
    xsi_vlog_unsigned_rshift(t22, 32, t20, 32, t21, 32);
    t23 = (t0 + 2408);
    xsi_vlogvar_assign_value(t23, t22, 0, 0, 32);
    goto LAB2;

}


extern void work_m_00000000003861230208_1994234593_init()
{
	static char *pe[] = {(void *)Always_38_0,(void *)Always_55_1};
	xsi_register_didat("work_m_00000000003861230208_1994234593", "isim/TB_CF_isim_beh.exe.sim/work/m_00000000003861230208_1994234593.didat");
	xsi_register_executes(pe);
}
