  //                                           );                                     
 
//endmodule


`timescale 1ns / 1ps

module q_func(
    input clk,
    input [31:0] X,
    input [31:0] N,
    input [31:0] T,
    
    output [31:0] Qfixed); 
    wire [31:0]Q;
    wire [31:0] Q10;
    wire s_tready_m10;
    wire m_tvalid_m10;
   wire s_tready_x,m_tvalid_x,m_tvalid_xt,s_tready_xd, s_tready_td, s_tready_lnd,
    s_tready_n, m_tvalid_n,s_tready_t, m_tvalid_t , s_tready_td2,  m_tvalid_lnt,
    s_tready_ln, m_tvalid_ln, s_tready_d,s_tready_m,m_tvalid_m;
wire [31:0]  float_m,float_x,float_t,float_xt, float_lnt,float_n,float_sq, float_lnn;
wire s_tready_sq,m_tvalid_sq,s_tready_add,s_tready_div, m_tvalid_add;
    wire [31:0] D = 32'd2;

floating_point_0 x1(
        .aclk(clk),
        .s_axis_a_tvalid(1'b1),//in
        .s_axis_a_tready(s_tready_x),//out
        .s_axis_a_tdata(X), //input
        .m_axis_result_tvalid(m_tvalid_x),// OUT STD_LOGIC;
        .m_axis_result_tready(1'b1), //: IN STD_LOGIC;
        .m_axis_result_tdata(float_x)  //: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
          );
floating_point_0 n2(
        .aclk(clk),
        .s_axis_a_tvalid(1'b1),//in
        .s_axis_a_tready(s_tready_n),//out
        .s_axis_a_tdata(N), //input
        .m_axis_result_tvalid(m_tvalid_n),// OUT STD_LOGIC;
        .m_axis_result_tready(1'b1), //: IN STD_LOGIC;
        .m_axis_result_tdata(float_n)  //: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
          );
floating_point_0 t2(
                  .aclk(clk),
                  .s_axis_a_tvalid(1'b1),//in
                  .s_axis_a_tready(s_tready_t),//out
                  .s_axis_a_tdata(T), //input
                  .m_axis_result_tvalid(m_tvalid_t),// OUT STD_LOGIC;
                  .m_axis_result_tready(1'b1), //: IN STD_LOGIC;
                  .m_axis_result_tdata(float_t)  //: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
                    );  
                    wire m_tvalid_d; wire [31:0] float_d;   
floating_point_0 d2(
      .aclk(clk),
      .s_axis_a_tvalid(1'b1),//in
      .s_axis_a_tready(s_tready_d),//out
      .s_axis_a_tdata(D), //input
      .m_axis_result_tvalid(m_tvalid_d),// OUT STD_LOGIC;
      .m_axis_result_tready(1'b1), //: IN STD_LOGIC;
      .m_axis_result_tdata(float_d)  //: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );                      
floating_point_1 IS(
    .aclk(clk),
    .s_axis_a_tvalid(m_tvalid_n),// : IN STD_LOGIC;
    .s_axis_a_tready(s_tready_ln),// : OUT STD_LOGIC;
    .s_axis_a_tdata(float_n), //: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    .m_axis_result_tvalid(m_tvalid_ln),// : OUT STD_LOGIC;
    .m_axis_result_tready(1'b1),
    .m_axis_result_tdata(float_lnn)
  );
floating_point_divide Id (
      .aclk(clk),
      .s_axis_a_tvalid(m_tvalid_x),
      .s_axis_a_tready(s_tready_xd),
      .s_axis_a_tdata(float_x),
      .s_axis_b_tvalid(m_tvalid_t),// : IN STD_LOGIC;
      .s_axis_b_tready(s_tready_td),// : OUT STD_LOGIC;
      .s_axis_b_tdata(float_t),// : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      .m_axis_result_tvalid(m_tvalid_xt),// : OUT STD_LOGIC;
      .m_axis_result_tready(m_tvalid_t),// : IN STD_LOGIC;
      .m_axis_result_tdata(float_xt)// : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );  
floating_point_divide Id2 (
          .aclk(clk),
          .s_axis_a_tvalid(m_tvalid_ln),
          .s_axis_a_tready(s_tready_lnd),
          .s_axis_a_tdata(float_lnn),
          .s_axis_b_tvalid(m_tvalid_t),// : IN STD_LOGIC;
          .s_axis_b_tready(s_tready_td2),// : OUT STD_LOGIC;
          .s_axis_b_tdata(float_t),// : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
          .m_axis_result_tvalid(m_tvalid_lnt),// : OUT STD_LOGIC;
          .m_axis_result_tready(m_tvalid_ln),// : IN STD_LOGIC;
          .m_axis_result_tdata(float_lnt)// : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        ); 

 floating_point_mul Im (
                  .aclk(clk),
                  .s_axis_a_tvalid(m_tvalid_d),
                //  .s_axis_a_tready(s_tready_d),
                  .s_axis_a_tdata(float_d),
                  .s_axis_b_tvalid(m_tvalid_lnt),// : IN STD_LOGIC;
                  .s_axis_b_tready(s_tready_m),// : OUT STD_LOGIC;
                  .s_axis_b_tdata(float_lnt),// : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
                  .m_axis_result_tvalid(m_tvalid_m),// : OUT STD_LOGIC;
                  .m_axis_result_tready(m_tvalid_lnt),// : IN STD_LOGIC;
                  .m_axis_result_tdata(float_m)// : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
                ); 
                
 floating_point_sqrt sq (
                    .aclk(clk),
                    .s_axis_a_tvalid(m_tvalid_m),// : IN STD_LOGIC;
                    .s_axis_a_tready(s_tready_sq),// : OUT STD_LOGIC;
                    .s_axis_a_tdata(float_m),// : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
                    .m_axis_result_tvalid(m_tvalid_sq),// : OUT STD_LOGIC;
                    .m_axis_result_tready(m_tvalid_m),// : IN STD_LOGIC;
                    .m_axis_result_tdata(float_sq)// : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
                  );                                         
floating_point_add b1(
                  .aclk(clk),
                  .s_axis_a_tvalid(m_tvalid_sq),//in
                  .s_axis_a_tready(s_tready_add),//out
                  .s_axis_a_tdata(float_sq), //input
                  .s_axis_b_tvalid(m_tvalid_xt),//in
                  .s_axis_b_tready(s_tready_div),//out
                  .s_axis_b_tdata(float_xt), //input
                  .m_axis_result_tvalid(m_tvalid_add),// OUT STD_LOGIC;
                  .m_axis_result_tready(m_tvalid_sq), //: IN STD_LOGIC;
                  .m_axis_result_tdata(Q)  //: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
                    );
 
 floating_point_mul Im10 (
      .aclk(clk),
      .s_axis_a_tvalid(m_tvalid_add),
    //  .s_axis_a_tready(s_tready_d),
      .s_axis_a_tdata(Q),
      .s_axis_b_tvalid(m_tvalid_add),// : IN STD_LOGIC;
      .s_axis_b_tready(s_tready_m10),// : OUT STD_LOGIC;
      .s_axis_b_tdata(32'h41200000),// : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      .m_axis_result_tvalid(m_tvalid_m10),// : OUT STD_LOGIC;
      .m_axis_result_tready(s_tready_add),// : IN STD_LOGIC;
      .m_axis_result_tdata(Q10)// : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
    
    float_to_fix answer (
      .aclk(clk),                                  // input wire aclk
      .s_axis_a_tvalid(s_tready_m10),            // input wire s_axis_a_tvalid
//      .s_axis_a_tready(),            // output wire s_axis_a_tready
      .s_axis_a_tdata(Q10),              // input wire [31 : 0] s_axis_a_tdata
//      .m_axis_result_tvalid(m_axis_result_tvalid),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(s_tready_m10),  // input wire m_axis_result_tready
      .m_axis_result_tdata(Qfixed)    // output wire [31 : 0] m_axis_result_tdata
    ); 
endmodule
