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

/* This file is designed for use with ISim build 0xc3576ebc */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/hlocal/chs/p1/simsum.vhd";
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_1547198987_1035706684(char *, char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_180853171_1035706684(char *, char *, int , int );


static void work_a_3864611916_0318166943_p_0(char *t0)
{
    char t10[16];
    char t18[16];
    char t19[16];
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    char *t6;
    char *t7;
    int t8;
    int t9;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    int64 t20;
    unsigned char t21;
    unsigned int t22;
    int t23;

LAB0:    t1 = (t0 + 2912U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 5140);
    *((int *)t2) = 0;
    t3 = (t0 + 5144);
    *((int *)t3) = 15;
    t4 = 0;
    t5 = 15;

LAB4:    if (t4 <= t5)
        goto LAB5;

LAB7:    xsi_set_current_line(62, ng0);

LAB32:    *((char **)t1) = &&LAB33;

LAB1:    return;
LAB5:    xsi_set_current_line(51, ng0);
    t6 = (t0 + 5148);
    *((int *)t6) = 0;
    t7 = (t0 + 5152);
    *((int *)t7) = 15;
    t8 = 0;
    t9 = 15;

LAB8:    if (t8 <= t9)
        goto LAB9;

LAB11:
LAB6:    t2 = (t0 + 5140);
    t4 = *((int *)t2);
    t3 = (t0 + 5144);
    t5 = *((int *)t3);
    if (t4 == t5)
        goto LAB7;

LAB29:    t8 = (t4 + 1);
    t4 = t8;
    t6 = (t0 + 5140);
    *((int *)t6) = t4;
    goto LAB4;

LAB9:    xsi_set_current_line(52, ng0);
    t11 = (t0 + 5140);
    t12 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t10, *((int *)t11), 4);
    t13 = (t0 + 3296);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t12, 4U);
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(53, ng0);
    t2 = (t0 + 5148);
    t3 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t10, *((int *)t2), 4);
    t6 = (t0 + 3360);
    t7 = (t6 + 56U);
    t11 = *((char **)t7);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t3, 4U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(54, ng0);
    t2 = (t0 + 5140);
    t3 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t18, *((int *)t2), 4);
    t6 = (t0 + 5148);
    t7 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t19, *((int *)t6), 4);
    t11 = ieee_p_1242562249_sub_1547198987_1035706684(IEEE_P_1242562249, t10, t3, t18, t7, t19);
    t12 = (t0 + 3424);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t11, 4U);
    xsi_driver_first_trans_fast(t12);
    xsi_set_current_line(55, ng0);
    t20 = (10 * 1000LL);
    t2 = (t0 + 2720);
    xsi_process_wait(t2, t20);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB10:    t2 = (t0 + 5148);
    t8 = *((int *)t2);
    t3 = (t0 + 5152);
    t9 = *((int *)t3);
    if (t8 == t9)
        goto LAB11;

LAB28:    t23 = (t8 + 1);
    t8 = t23;
    t6 = (t0 + 5148);
    *((int *)t6) = t8;
    goto LAB8;

LAB12:    xsi_set_current_line(56, ng0);
    t2 = (t0 + 1352U);
    t3 = *((char **)t2);
    t2 = (t0 + 1512U);
    t6 = *((char **)t2);
    t21 = 1;
    if (4U == 4U)
        goto LAB18;

LAB19:    t21 = 0;

LAB20:    if (t21 == 0)
        goto LAB16;

LAB17:    xsi_set_current_line(59, ng0);
    t20 = (10 * 1000LL);
    t2 = (t0 + 2720);
    xsi_process_wait(t2, t20);

LAB26:    *((char **)t1) = &&LAB27;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB16:    t11 = (t0 + 5156);
    xsi_report(t11, 22U, (unsigned char)2);
    goto LAB17;

LAB18:    t22 = 0;

LAB21:    if (t22 < 4U)
        goto LAB22;
    else
        goto LAB20;

LAB22:    t2 = (t3 + t22);
    t7 = (t6 + t22);
    if (*((unsigned char *)t2) != *((unsigned char *)t7))
        goto LAB19;

LAB23:    t22 = (t22 + 1);
    goto LAB21;

LAB24:    goto LAB10;

LAB25:    goto LAB24;

LAB27:    goto LAB25;

LAB30:    goto LAB2;

LAB31:    goto LAB30;

LAB33:    goto LAB31;

}


extern void work_a_3864611916_0318166943_init()
{
	static char *pe[] = {(void *)work_a_3864611916_0318166943_p_0};
	xsi_register_didat("work_a_3864611916_0318166943", "isim/tb_sumador_4bits_isim_beh.exe.sim/work/a_3864611916_0318166943.didat");
	xsi_register_executes(pe);
}
