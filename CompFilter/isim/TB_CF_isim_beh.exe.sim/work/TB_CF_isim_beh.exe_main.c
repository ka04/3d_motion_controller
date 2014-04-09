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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    unisims_ver_m_00000000003927721830_1593237687_init();
    unisims_ver_m_00000000003317509437_1759035934_init();
    unisims_ver_m_00000000003405408344_3841093685_init();
    unisims_ver_m_00000000000129024098_1730278898_init();
    unisims_ver_m_00000000002601448656_3367321443_init();
    unisims_ver_m_00000000001108370118_3204134789_init();
    unisims_ver_m_00000000001108370118_1660583624_init();
    unisims_ver_m_00000000001108370118_2500128490_init();
    unisims_ver_m_00000000001108370118_3102277666_init();
    unisims_ver_m_00000000001773747898_0266641171_init();
    unisims_ver_m_00000000001773747898_2454832694_init();
    unisims_ver_m_00000000001773747898_2336946039_init();
    unisims_ver_m_00000000001773747898_0257217429_init();
    unisims_ver_m_00000000001773747898_0374334164_init();
    unisims_ver_m_00000000001784029001_2788456746_init();
    unisims_ver_m_00000000000236260522_2449448540_init();
    unisims_ver_m_00000000004221170615_0679316750_init();
    unisims_ver_m_00000000001508379050_3852734344_init();
    unisims_ver_m_00000000003848737514_1058825862_init();
    unisims_ver_m_00000000000909115699_2771340377_init();
    unisims_ver_m_00000000002444920515_2091797430_init();
    work_m_00000000001482823674_0979632789_init();
    work_m_00000000003861230208_1994234593_init();
    work_m_00000000003797684103_0392554275_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000003797684103_0392554275");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
