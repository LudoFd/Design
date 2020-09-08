--
-- Written by Synplicity
-- Product Version "L-2016.09L+ice40"
-- Program "Synplify Pro", Mapper "maplat, Build 1612R"
-- Mon Sep 07 17:03:30 2020
--

--
-- Written by Synplify Pro version Build 1612R
-- Mon Sep 07 17:03:30 2020
--

--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--library synplify;
--use synplify.components.all;
library work;
use work.vcomponent_vital.all; 
use work.std_logic_SBT.all; 

entity transmitter is
port(
  counter : in std_logic_vector(10 downto 0);
  tx_BinaryCode : in std_logic_vector(7 downto 0);
  rx_BinaryCode : in std_logic_vector(7 downto 0);
  o_UART_TX_c :  out std_logic;
  i_Clk_c_g :  in std_logic;
  un14_counter :  out std_logic;
  counter9_0 :  out std_logic);
end transmitter;

architecture beh of transmitter is
  signal TX_BIT_COUNTER_I : std_logic_vector(2 downto 1);
  signal TX_BIT_COUNTER : std_logic_vector(3 downto 0);
  signal I : std_logic_vector(2 downto 0);
  signal I_4 : std_logic_vector(2 downto 0);
  signal TX_FSM_STATE : std_logic_vector(1 downto 0);
  signal TX_FSM_STATE_NS_0_I : std_logic_vector(1 to 1);
  signal NBR_STOPBITS : std_logic_vector(1 downto 0);
  signal NBR_STOPBITS_RNO : std_logic_vector(1 to 1);
  signal TX_FSM_STATE_NS_I_0 : std_logic_vector(0 to 0);
  signal TX_BIT_COUNTER_RNIRE5A8 : std_logic_vector(3 to 3);
  signal TX_FSM_STATE_NS_I_A4_0_0 : std_logic_vector(0 to 0);
  signal TX_FSM_STATE_NS_I_A4_0_1 : std_logic_vector(0 to 0);
  signal TX_FSM_STATE_NS_I_A4_0_5 : std_logic_vector(0 to 0);
  signal NUTZFRAME_IN : std_logic_vector(7 downto 0);
  signal TX_FSM_STATE_NS_I_A4_0_3 : std_logic_vector(0 to 0);
  signal TX_ABSTATER : std_logic_vector(18 downto 0);
  signal TX_ABSTATER_I : std_logic_vector(0 to 0);
  signal TX_BIT_COUNTER_RNO : std_logic_vector(3 downto 0);
  signal TX_ABSTATER_RNO : std_logic_vector(18 downto 1);
  signal UN19_TX_ABSTATER_0_I : std_logic ;
  signal UN19_TX_ABSTATER_AXB_3 : std_logic ;
  signal UN1_TX_FSM_STATE_0_I_G : std_logic ;
  signal UN1_TX_FSM_STATE_0_I : std_logic ;
  signal NN_1 : std_logic ;
  signal NN_2 : std_logic ;
  signal CO0 : std_logic ;
  signal UN2_TX_ABSTATER_0 : std_logic ;
  signal N_188_0 : std_logic ;
  signal N_207_0 : std_logic ;
  signal N_190_0_1 : std_logic ;
  signal N_168_0 : std_logic ;
  signal N_93 : std_logic ;
  signal N_212 : std_logic ;
  signal N_204_0 : std_logic ;
  signal N_212_1 : std_logic ;
  signal UN2_TX_ABSTATER_1 : std_logic ;
  signal TX_DATA_IN_3 : std_logic ;
  signal TX_DATA_IN_4 : std_logic ;
  signal UN19_TX_ABSTATER : std_logic ;
  signal COUNTER9_12 : std_logic ;
  signal UN14_COUNTER_5 : std_logic ;
  signal UN14_COUNTER_6 : std_logic ;
  signal UN14_COUNTER_7 : std_logic ;
  signal UN17_TX_FSM_STATE_0_O3_0_A2_11 : std_logic ;
  signal UN17_TX_FSM_STATE_0_O3_0_A2_12 : std_logic ;
  signal UN17_TX_FSM_STATE_0_O3_0_A2_13 : std_logic ;
  signal UN17_TX_FSM_STATE_0_O3_0_A2_14 : std_logic ;
  signal UN15_COUNTER_NE_0 : std_logic ;
  signal UN15_COUNTER_NE_1 : std_logic ;
  signal UN15_COUNTER_NE_2 : std_logic ;
  signal UN15_COUNTER_NE_3 : std_logic ;
  signal N_210_0 : std_logic ;
  signal TX_DATA_IN_RNO_4 : std_logic ;
  signal TX_DATA_IN_RNO_5 : std_logic ;
  signal TX_DATA_IN_RNO_1 : std_logic ;
  signal TX_DATA_IN_RNO_2 : std_logic ;
  signal UN9_TX_FSM_STATE_4 : std_logic ;
  signal UN17_TX_FSM_STATE_0_O3_0_A2_10 : std_logic ;
  signal TX_DATA_IN_3_7_NS_1 : std_logic ;
  signal UN3_TX_BIT_COUNTER_1_CRY_1 : std_logic ;
  signal UN3_TX_BIT_COUNTER_1_CRY_0 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_16 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_15 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_14 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_13 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_12 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_11 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_10 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_9 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_8 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_7 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_6 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_5 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_4 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_3 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_2 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_1 : std_logic ;
  signal UN3_TX_BIT_COUNTER_1_CRY_2 : std_logic ;
  signal UN1_TX_ABSTATER_1_CRY_17 : std_logic ;
  signal UN19_TX_ABSTATER_CRY_0 : std_logic ;
  signal UN19_TX_ABSTATER_CRY_1 : std_logic ;
  signal UN19_TX_ABSTATER_CRY_2 : std_logic ;
  signal N_64 : std_logic ;
  signal N_63 : std_logic ;
  signal N_62 : std_logic ;
  signal N_61 : std_logic ;
  signal N_1 : std_logic ;
  signal N_2 : std_logic ;
  signal N_3 : std_logic ;
  signal N_4 : std_logic ;
begin
\TX_FSM_STATE_RNI1KRA8_0[1]\: SB_GB port map (
    GLOBAL_BUFFER_OUTPUT => UN1_TX_FSM_STATE_0_I_G,
    USER_SIGNAL_TO_GLOBAL_BUFFER => UN1_TX_FSM_STATE_0_I);
\FSM_TX.UN19_TX_ABSTATER_CRY_3_C_INV\: SB_LUT4 
generic map(
  LUT_INIT => X"5555"
)
port map (
  I0 => TX_BIT_COUNTER(3),
  I1 => N_4,
  I2 => NN_1,
  I3 => NN_1,
  O => UN19_TX_ABSTATER_AXB_3);
\FSM_TX.UN19_TX_ABSTATER_CRY_2_C_INV\: SB_LUT4 
generic map(
  LUT_INIT => X"5555"
)
port map (
  I0 => TX_BIT_COUNTER(2),
  I1 => NN_2,
  I2 => N_3,
  I3 => NN_1,
  O => TX_BIT_COUNTER_I(2));
\FSM_TX.UN19_TX_ABSTATER_CRY_1_C_INV\: SB_LUT4 
generic map(
  LUT_INIT => X"5555"
)
port map (
  I0 => TX_BIT_COUNTER(1),
  I1 => NN_2,
  I2 => N_2,
  I3 => NN_1,
  O => TX_BIT_COUNTER_I(1));
\FSM_TX.UN19_TX_ABSTATER_CRY_0_C_INV\: SB_LUT4 
generic map(
  LUT_INIT => X"5555"
)
port map (
  I0 => TX_BIT_COUNTER(0),
  I1 => N_1,
  I2 => NN_2,
  I3 => NN_1,
  O => UN19_TX_ABSTATER_0_I);
\I_RNO[2]\: SB_LUT4 
generic map(
  LUT_INIT => X"0078"
)
port map (
  I0 => CO0,
  I1 => I(1),
  I2 => I(2),
  I3 => UN2_TX_ABSTATER_0,
  O => I_4(2));
\I_RNO[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"0606"
)
port map (
  I0 => CO0,
  I1 => I(1),
  I2 => UN2_TX_ABSTATER_0,
  I3 => NN_1,
  O => I_4(1));
\TX_FSM_STATE_RNO[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"3FA0"
)
port map (
  I0 => N_188_0,
  I1 => N_207_0,
  I2 => TX_FSM_STATE(0),
  I3 => TX_FSM_STATE(1),
  O => TX_FSM_STATE_NS_0_I(1));
\NBR_STOPBITS_RNO[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"6C6C"
)
port map (
  I0 => N_190_0_1,
  I1 => NBR_STOPBITS(0),
  I2 => TX_FSM_STATE(1),
  I3 => NN_1,
  O => N_168_0);
\I_RNO[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"00C6"
)
port map (
  I0 => N_93,
  I1 => I(0),
  I2 => TX_FSM_STATE(0),
  I3 => UN2_TX_ABSTATER_0,
  O => I_4(0));
\NBR_STOPBITS_RNO[1]_Z208\: SB_LUT4 
generic map(
  LUT_INIT => X"78F0"
)
port map (
  I0 => N_190_0_1,
  I1 => NBR_STOPBITS(0),
  I2 => NBR_STOPBITS(1),
  I3 => TX_FSM_STATE(1),
  O => NBR_STOPBITS_RNO(1));
\TX_FSM_STATE_RNO[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"3100"
)
port map (
  I0 => N_190_0_1,
  I1 => N_212,
  I2 => TX_FSM_STATE(1),
  I3 => TX_FSM_STATE_NS_I_0(0),
  O => N_204_0);
\TX_FSM_STATE_RNI1KRA8[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"EEEE"
)
port map (
  I0 => N_188_0,
  I1 => N_212_1,
  I2 => NN_1,
  I3 => NN_1,
  O => UN1_TX_FSM_STATE_0_I);
\TX_BIT_COUNTER_RNIIBJU9[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"0100"
)
port map (
  I0 => N_93,
  I1 => TX_BIT_COUNTER(0),
  I2 => TX_BIT_COUNTER(3),
  I3 => UN2_TX_ABSTATER_1,
  O => UN2_TX_ABSTATER_0);
TX_DATA_IN_RNO: SB_LUT4 
generic map(
  LUT_INIT => X"E3E3"
)
port map (
  I0 => TX_DATA_IN_3,
  I1 => TX_FSM_STATE(0),
  I2 => TX_FSM_STATE(1),
  I3 => NN_1,
  O => TX_DATA_IN_4);
\TX_FSM_STATE_RNIISTQ7[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"8888"
)
port map (
  I0 => N_188_0,
  I1 => TX_FSM_STATE(0),
  I2 => NN_1,
  I3 => NN_1,
  O => N_190_0_1);
\FSM_TX.UN19_TX_ABSTATER_CRY_3_C_RNI6INH7\: SB_LUT4 
generic map(
  LUT_INIT => X"CC00"
)
port map (
  I0 => NN_1,
  I1 => N_188_0,
  I2 => NN_1,
  I3 => UN19_TX_ABSTATER,
  O => N_93);
\TX_BIT_COUNTER_RNIRE5A8[3]_Z215\: SB_LUT4 
generic map(
  LUT_INIT => X"0202"
)
port map (
  I0 => N_188_0,
  I1 => TX_BIT_COUNTER(3),
  I2 => TX_FSM_STATE(0),
  I3 => NN_1,
  O => TX_BIT_COUNTER_RNIRE5A8(3));
\TX_FSM_STATE_RNO_0[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"8000"
)
port map (
  I0 => N_212_1,
  I1 => TX_FSM_STATE_NS_I_A4_0_0(0),
  I2 => TX_FSM_STATE_NS_I_A4_0_1(0),
  I3 => TX_FSM_STATE_NS_I_A4_0_5(0),
  O => N_212);
\PARALLIZING.UN14_COUNTER\: SB_LUT4 
generic map(
  LUT_INIT => X"4000"
)
port map (
  I0 => COUNTER9_12,
  I1 => UN14_COUNTER_5,
  I2 => UN14_COUNTER_6,
  I3 => UN14_COUNTER_7,
  O => un14_counter);
\TX_ABSTATER_RNI460B7[11]\: SB_LUT4 
generic map(
  LUT_INIT => X"8000"
)
port map (
  I0 => UN17_TX_FSM_STATE_0_O3_0_A2_11,
  I1 => UN17_TX_FSM_STATE_0_O3_0_A2_12,
  I2 => UN17_TX_FSM_STATE_0_O3_0_A2_13,
  I3 => UN17_TX_FSM_STATE_0_O3_0_A2_14,
  O => N_188_0);
\PARALLIZING.UN15_COUNTER_NE\: SB_LUT4 
generic map(
  LUT_INIT => X"8000"
)
port map (
  I0 => UN15_COUNTER_NE_0,
  I1 => UN15_COUNTER_NE_1,
  I2 => UN15_COUNTER_NE_2,
  I3 => UN15_COUNTER_NE_3,
  O => COUNTER9_12);
\TX_FSM_STATE_RNO_1[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"5CFF"
)
port map (
  I0 => N_207_0,
  I1 => N_210_0,
  I2 => TX_FSM_STATE(0),
  I3 => TX_FSM_STATE(1),
  O => TX_FSM_STATE_NS_I_0(0));
TX_DATA_IN_RNO_4_Z221: SB_LUT4 
generic map(
  LUT_INIT => X"CACA"
)
port map (
  I0 => NUTZFRAME_IN(0),
  I1 => NUTZFRAME_IN(4),
  I2 => I(2),
  I3 => NN_1,
  O => TX_DATA_IN_RNO_4);
TX_DATA_IN_RNO_5_Z222: SB_LUT4 
generic map(
  LUT_INIT => X"CACA"
)
port map (
  I0 => NUTZFRAME_IN(2),
  I1 => NUTZFRAME_IN(6),
  I2 => I(2),
  I3 => NN_1,
  O => TX_DATA_IN_RNO_5);
TX_DATA_IN_RNO_1_Z223: SB_LUT4 
generic map(
  LUT_INIT => X"CACA"
)
port map (
  I0 => NUTZFRAME_IN(1),
  I1 => NUTZFRAME_IN(5),
  I2 => I(2),
  I3 => NN_1,
  O => TX_DATA_IN_RNO_1);
TX_DATA_IN_RNO_2_Z224: SB_LUT4 
generic map(
  LUT_INIT => X"CACA"
)
port map (
  I0 => NUTZFRAME_IN(3),
  I1 => NUTZFRAME_IN(7),
  I2 => I(2),
  I3 => NN_1,
  O => TX_DATA_IN_RNO_2);
\TX_FSM_STATE_RNO_4[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"0804"
)
port map (
  I0 => NUTZFRAME_IN(5),
  I1 => TX_FSM_STATE_NS_I_A4_0_3(0),
  I2 => UN9_TX_FSM_STATE_4,
  I3 => tx_BinaryCode(5),
  O => TX_FSM_STATE_NS_I_A4_0_5(0));
\TX_ABSTATER_RNIS3TN2[5]\: SB_LUT4 
generic map(
  LUT_INIT => X"1000"
)
port map (
  I0 => TX_ABSTATER(0),
  I1 => TX_ABSTATER(5),
  I2 => TX_ABSTATER(6),
  I3 => UN17_TX_FSM_STATE_0_O3_0_A2_10,
  O => UN17_TX_FSM_STATE_0_O3_0_A2_14);
\TX_FSM_STATE_RNO_5[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"0100"
)
port map (
  I0 => TX_BIT_COUNTER(0),
  I1 => TX_BIT_COUNTER(1),
  I2 => TX_BIT_COUNTER(2),
  I3 => TX_BIT_COUNTER(3),
  O => N_210_0);
\PARALLIZING.UN15_COUNTER_NE_0\: SB_LUT4 
generic map(
  LUT_INIT => X"8421"
)
port map (
  I0 => rx_BinaryCode(6),
  I1 => rx_BinaryCode(7),
  I2 => tx_BinaryCode(6),
  I3 => tx_BinaryCode(7),
  O => UN15_COUNTER_NE_0);
\PARALLIZING.UN15_COUNTER_NE_1\: SB_LUT4 
generic map(
  LUT_INIT => X"8421"
)
port map (
  I0 => rx_BinaryCode(4),
  I1 => rx_BinaryCode(5),
  I2 => tx_BinaryCode(4),
  I3 => tx_BinaryCode(5),
  O => UN15_COUNTER_NE_1);
\PARALLIZING.UN15_COUNTER_NE_2\: SB_LUT4 
generic map(
  LUT_INIT => X"8421"
)
port map (
  I0 => rx_BinaryCode(2),
  I1 => rx_BinaryCode(3),
  I2 => tx_BinaryCode(2),
  I3 => tx_BinaryCode(3),
  O => UN15_COUNTER_NE_2);
\PARALLIZING.UN15_COUNTER_NE_3\: SB_LUT4 
generic map(
  LUT_INIT => X"8421"
)
port map (
  I0 => rx_BinaryCode(0),
  I1 => rx_BinaryCode(1),
  I2 => tx_BinaryCode(0),
  I3 => tx_BinaryCode(1),
  O => UN15_COUNTER_NE_3);
\TX_FSM_STATE_RNO_2[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"8421"
)
port map (
  I0 => NUTZFRAME_IN(0),
  I1 => NUTZFRAME_IN(1),
  I2 => tx_BinaryCode(0),
  I3 => tx_BinaryCode(1),
  O => TX_FSM_STATE_NS_I_A4_0_0(0));
\TX_FSM_STATE_RNO_3[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"8421"
)
port map (
  I0 => NUTZFRAME_IN(2),
  I1 => NUTZFRAME_IN(3),
  I2 => tx_BinaryCode(2),
  I3 => tx_BinaryCode(3),
  O => TX_FSM_STATE_NS_I_A4_0_1(0));
\TX_FSM_STATE_RNO_6[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"8421"
)
port map (
  I0 => NUTZFRAME_IN(6),
  I1 => NUTZFRAME_IN(7),
  I2 => tx_BinaryCode(6),
  I3 => tx_BinaryCode(7),
  O => TX_FSM_STATE_NS_I_A4_0_3(0));
\TX_ABSTATER_RNINDPC1[10]\: SB_LUT4 
generic map(
  LUT_INIT => X"0002"
)
port map (
  I0 => TX_ABSTATER(7),
  I1 => TX_ABSTATER(10),
  I2 => TX_ABSTATER(12),
  I3 => TX_ABSTATER(13),
  O => UN17_TX_FSM_STATE_0_O3_0_A2_10);
\TX_ABSTATER_RNI1H8L1[15]\: SB_LUT4 
generic map(
  LUT_INIT => X"0001"
)
port map (
  I0 => TX_ABSTATER(2),
  I1 => TX_ABSTATER(8),
  I2 => TX_ABSTATER(9),
  I3 => TX_ABSTATER(15),
  O => UN17_TX_FSM_STATE_0_O3_0_A2_11);
\TX_ABSTATER_RNIE8I81[11]\: SB_LUT4 
generic map(
  LUT_INIT => X"0001"
)
port map (
  I0 => TX_ABSTATER(11),
  I1 => TX_ABSTATER(14),
  I2 => TX_ABSTATER(16),
  I3 => TX_ABSTATER(17),
  O => UN17_TX_FSM_STATE_0_O3_0_A2_12);
\TX_ABSTATER_RNIP88L1[18]\: SB_LUT4 
generic map(
  LUT_INIT => X"0040"
)
port map (
  I0 => TX_ABSTATER(1),
  I1 => TX_ABSTATER(3),
  I2 => TX_ABSTATER(4),
  I3 => TX_ABSTATER(18),
  O => UN17_TX_FSM_STATE_0_O3_0_A2_13);
\PARALLIZING.UN14_COUNTER_5\: SB_LUT4 
generic map(
  LUT_INIT => X"8080"
)
port map (
  I0 => counter(0),
  I1 => counter(2),
  I2 => counter(6),
  I3 => NN_1,
  O => UN14_COUNTER_5);
\PARALLIZING.UN14_COUNTER_6\: SB_LUT4 
generic map(
  LUT_INIT => X"2000"
)
port map (
  I0 => counter(7),
  I1 => counter(8),
  I2 => counter(9),
  I3 => counter(10),
  O => UN14_COUNTER_6);
\PARALLIZING.UN14_COUNTER_7\: SB_LUT4 
generic map(
  LUT_INIT => X"0001"
)
port map (
  I0 => counter(1),
  I1 => counter(3),
  I2 => counter(4),
  I3 => counter(5),
  O => UN14_COUNTER_7);
\TX_BIT_COUNTER_RNITNCE1[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"0101"
)
port map (
  I0 => TX_BIT_COUNTER(1),
  I1 => TX_BIT_COUNTER(2),
  I2 => TX_FSM_STATE(0),
  I3 => NN_1,
  O => UN2_TX_ABSTATER_1);
\TX_FSM_STATE_RNITDRV[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"1111"
)
port map (
  I0 => TX_FSM_STATE(0),
  I1 => TX_FSM_STATE(1),
  I2 => NN_1,
  I3 => NN_1,
  O => N_212_1);
\NBR_STOPBITS_RNIDK6A[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"2222"
)
port map (
  I0 => NBR_STOPBITS(0),
  I1 => NBR_STOPBITS(1),
  I2 => NN_1,
  I3 => NN_1,
  O => N_207_0);
\TX_FSM_STATE_RNO_7[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"6666"
)
port map (
  I0 => NUTZFRAME_IN(4),
  I1 => tx_BinaryCode(4),
  I2 => NN_1,
  I3 => NN_1,
  O => UN9_TX_FSM_STATE_4);
\TX_ABSTATER_RNO[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"5555"
)
port map (
  I0 => TX_ABSTATER(0),
  I1 => NN_1,
  I2 => NN_1,
  I3 => NN_1,
  O => TX_ABSTATER_I(0));
TX_DATA_IN_RNO_3: SB_LUT4 
generic map(
  LUT_INIT => X"03F5"
)
port map (
  I0 => TX_DATA_IN_RNO_4,
  I1 => TX_DATA_IN_RNO_5,
  I2 => I(0),
  I3 => I(1),
  O => TX_DATA_IN_3_7_NS_1);
TX_DATA_IN_RNO_0: SB_LUT4 
generic map(
  LUT_INIT => X"AC0F"
)
port map (
  I0 => TX_DATA_IN_RNO_1,
  I1 => TX_DATA_IN_RNO_2,
  I2 => TX_DATA_IN_3_7_NS_1,
  I3 => I(0),
  O => TX_DATA_IN_3);
\FSM_TX.UN19_TX_ABSTATER_CRY_3_C_RNIQRL78\: SB_LUT4 
generic map(
  LUT_INIT => X"4000"
)
port map (
  I0 => TX_FSM_STATE(0),
  I1 => I(0),
  I2 => N_188_0,
  I3 => UN19_TX_ABSTATER,
  O => CO0);
\TX_BIT_COUNTER_RNO[2]_Z250\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_BIT_COUNTER(2),
  I2 => NN_1,
  I3 => UN3_TX_BIT_COUNTER_1_CRY_1,
  O => TX_BIT_COUNTER_RNO(2));
\TX_BIT_COUNTER_RNO[1]_Z251\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_BIT_COUNTER(1),
  I2 => NN_1,
  I3 => UN3_TX_BIT_COUNTER_1_CRY_0,
  O => TX_BIT_COUNTER_RNO(1));
\TX_BIT_COUNTER_RNO[0]_Z252\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_BIT_COUNTER(0),
  I2 => NN_1,
  I3 => TX_BIT_COUNTER_RNIRE5A8(3),
  O => TX_BIT_COUNTER_RNO(0));
\TX_ABSTATER_RNO[17]_Z253\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(17),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_16,
  O => TX_ABSTATER_RNO(17));
\TX_ABSTATER_RNO[16]_Z254\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(16),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_15,
  O => TX_ABSTATER_RNO(16));
\TX_ABSTATER_RNO[15]_Z255\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(15),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_14,
  O => TX_ABSTATER_RNO(15));
\TX_ABSTATER_RNO[14]_Z256\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(14),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_13,
  O => TX_ABSTATER_RNO(14));
\TX_ABSTATER_RNO[13]_Z257\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(13),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_12,
  O => TX_ABSTATER_RNO(13));
\TX_ABSTATER_RNO[12]_Z258\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(12),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_11,
  O => TX_ABSTATER_RNO(12));
\TX_ABSTATER_RNO[11]_Z259\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(11),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_10,
  O => TX_ABSTATER_RNO(11));
\TX_ABSTATER_RNO[10]_Z260\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(10),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_9,
  O => TX_ABSTATER_RNO(10));
\TX_ABSTATER_RNO[9]_Z261\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(9),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_8,
  O => TX_ABSTATER_RNO(9));
\TX_ABSTATER_RNO[8]_Z262\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(8),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_7,
  O => TX_ABSTATER_RNO(8));
\TX_ABSTATER_RNO[7]_Z263\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(7),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_6,
  O => TX_ABSTATER_RNO(7));
\TX_ABSTATER_RNO[6]_Z264\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(6),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_5,
  O => TX_ABSTATER_RNO(6));
\TX_ABSTATER_RNO[5]_Z265\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(5),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_4,
  O => TX_ABSTATER_RNO(5));
\TX_ABSTATER_RNO[4]_Z266\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(4),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_3,
  O => TX_ABSTATER_RNO(4));
\TX_ABSTATER_RNO[3]_Z267\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(3),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_2,
  O => TX_ABSTATER_RNO(3));
\TX_ABSTATER_RNO[2]_Z268\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(2),
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_1,
  O => TX_ABSTATER_RNO(2));
\TX_ABSTATER_RNO[1]_Z269\: SB_LUT4 
generic map(
  LUT_INIT => X"C33C"
)
port map (
  I0 => NN_1,
  I1 => TX_ABSTATER(1),
  I2 => NN_1,
  I3 => TX_ABSTATER(0),
  O => TX_ABSTATER_RNO(1));
\TX_BIT_COUNTER_RNO[3]_Z270\: SB_LUT4 
generic map(
  LUT_INIT => X"55AA"
)
port map (
  I0 => TX_BIT_COUNTER(3),
  I1 => NN_1,
  I2 => NN_1,
  I3 => UN3_TX_BIT_COUNTER_1_CRY_2,
  O => TX_BIT_COUNTER_RNO(3));
\TX_ABSTATER_RNO[18]_Z271\: SB_LUT4 
generic map(
  LUT_INIT => X"55AA"
)
port map (
  I0 => TX_ABSTATER(18),
  I1 => NN_1,
  I2 => NN_1,
  I3 => UN1_TX_ABSTATER_1_CRY_17,
  O => TX_ABSTATER_RNO(18));
\I[0]_Z272\: SB_DFFSR port map (
    Q => I(0),
    D => I_4(0),
    C => i_Clk_c_g,
    R => N_212_1);
\I[1]_Z273\: SB_DFFSR port map (
    Q => I(1),
    D => I_4(1),
    C => i_Clk_c_g,
    R => N_212_1);
\I[2]_Z274\: SB_DFFSR port map (
    Q => I(2),
    D => I_4(2),
    C => i_Clk_c_g,
    R => N_212_1);
\NBR_STOPBITS[0]_Z275\: SB_DFFSR port map (
    Q => NBR_STOPBITS(0),
    D => N_168_0,
    C => i_Clk_c_g,
    R => N_212_1);
\NBR_STOPBITS[1]_Z276\: SB_DFFSR port map (
    Q => NBR_STOPBITS(1),
    D => NBR_STOPBITS_RNO(1),
    C => i_Clk_c_g,
    R => N_212_1);
TX_DATA_IN: SB_DFFSS port map (
    Q => o_UART_TX_c,
    D => TX_DATA_IN_4,
    C => i_Clk_c_g,
    S => N_212_1);
\TX_ABSTATER[0]_Z278\: SB_DFFSR port map (
    Q => TX_ABSTATER(0),
    D => TX_ABSTATER_I(0),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[1]_Z279\: SB_DFFSR port map (
    Q => TX_ABSTATER(1),
    D => TX_ABSTATER_RNO(1),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[2]_Z280\: SB_DFFSR port map (
    Q => TX_ABSTATER(2),
    D => TX_ABSTATER_RNO(2),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[3]_Z281\: SB_DFFSR port map (
    Q => TX_ABSTATER(3),
    D => TX_ABSTATER_RNO(3),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[4]_Z282\: SB_DFFSR port map (
    Q => TX_ABSTATER(4),
    D => TX_ABSTATER_RNO(4),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[5]_Z283\: SB_DFFSR port map (
    Q => TX_ABSTATER(5),
    D => TX_ABSTATER_RNO(5),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[6]_Z284\: SB_DFFSR port map (
    Q => TX_ABSTATER(6),
    D => TX_ABSTATER_RNO(6),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[7]_Z285\: SB_DFFSR port map (
    Q => TX_ABSTATER(7),
    D => TX_ABSTATER_RNO(7),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[8]_Z286\: SB_DFFSR port map (
    Q => TX_ABSTATER(8),
    D => TX_ABSTATER_RNO(8),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[9]_Z287\: SB_DFFSR port map (
    Q => TX_ABSTATER(9),
    D => TX_ABSTATER_RNO(9),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[10]_Z288\: SB_DFFSR port map (
    Q => TX_ABSTATER(10),
    D => TX_ABSTATER_RNO(10),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[11]_Z289\: SB_DFFSR port map (
    Q => TX_ABSTATER(11),
    D => TX_ABSTATER_RNO(11),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[12]_Z290\: SB_DFFSR port map (
    Q => TX_ABSTATER(12),
    D => TX_ABSTATER_RNO(12),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[13]_Z291\: SB_DFFSR port map (
    Q => TX_ABSTATER(13),
    D => TX_ABSTATER_RNO(13),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[14]_Z292\: SB_DFFSR port map (
    Q => TX_ABSTATER(14),
    D => TX_ABSTATER_RNO(14),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[15]_Z293\: SB_DFFSR port map (
    Q => TX_ABSTATER(15),
    D => TX_ABSTATER_RNO(15),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[16]_Z294\: SB_DFFSR port map (
    Q => TX_ABSTATER(16),
    D => TX_ABSTATER_RNO(16),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[17]_Z295\: SB_DFFSR port map (
    Q => TX_ABSTATER(17),
    D => TX_ABSTATER_RNO(17),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_ABSTATER[18]_Z296\: SB_DFFSR port map (
    Q => TX_ABSTATER(18),
    D => TX_ABSTATER_RNO(18),
    C => i_Clk_c_g,
    R => UN1_TX_FSM_STATE_0_I_G);
\TX_BIT_COUNTER[0]_Z297\: SB_DFFSR port map (
    Q => TX_BIT_COUNTER(0),
    D => TX_BIT_COUNTER_RNO(0),
    C => i_Clk_c_g,
    R => N_212_1);
\TX_BIT_COUNTER[1]_Z298\: SB_DFFSR port map (
    Q => TX_BIT_COUNTER(1),
    D => TX_BIT_COUNTER_RNO(1),
    C => i_Clk_c_g,
    R => N_212_1);
\TX_BIT_COUNTER[2]_Z299\: SB_DFFSR port map (
    Q => TX_BIT_COUNTER(2),
    D => TX_BIT_COUNTER_RNO(2),
    C => i_Clk_c_g,
    R => N_212_1);
\TX_BIT_COUNTER[3]_Z300\: SB_DFFSR port map (
    Q => TX_BIT_COUNTER(3),
    D => TX_BIT_COUNTER_RNO(3),
    C => i_Clk_c_g,
    R => N_212_1);
\NUTZFRAME_IN[1]_Z301\: SB_DFF port map (
    Q => NUTZFRAME_IN(1),
    D => tx_BinaryCode(1),
    C => i_Clk_c_g);
\NUTZFRAME_IN[2]_Z302\: SB_DFF port map (
    Q => NUTZFRAME_IN(2),
    D => tx_BinaryCode(2),
    C => i_Clk_c_g);
\NUTZFRAME_IN[3]_Z303\: SB_DFF port map (
    Q => NUTZFRAME_IN(3),
    D => tx_BinaryCode(3),
    C => i_Clk_c_g);
\NUTZFRAME_IN[4]_Z304\: SB_DFF port map (
    Q => NUTZFRAME_IN(4),
    D => tx_BinaryCode(4),
    C => i_Clk_c_g);
\NUTZFRAME_IN[5]_Z305\: SB_DFF port map (
    Q => NUTZFRAME_IN(5),
    D => tx_BinaryCode(5),
    C => i_Clk_c_g);
\NUTZFRAME_IN[6]_Z306\: SB_DFF port map (
    Q => NUTZFRAME_IN(6),
    D => tx_BinaryCode(6),
    C => i_Clk_c_g);
\NUTZFRAME_IN[7]_Z307\: SB_DFF port map (
    Q => NUTZFRAME_IN(7),
    D => tx_BinaryCode(7),
    C => i_Clk_c_g);
\NUTZFRAME_IN[0]_Z308\: SB_DFF port map (
    Q => NUTZFRAME_IN(0),
    D => tx_BinaryCode(0),
    C => i_Clk_c_g);
\TX_FSM_STATE[0]_Z309\: SB_DFF port map (
    Q => TX_FSM_STATE(0),
    D => N_204_0,
    C => i_Clk_c_g);
\TX_FSM_STATE[1]_Z310\: SB_DFF port map (
    Q => TX_FSM_STATE(1),
    D => TX_FSM_STATE_NS_0_I(1),
    C => i_Clk_c_g);
\FSM_TX.UN19_TX_ABSTATER_CRY_0_C\: SB_CARRY port map (
    CO => UN19_TX_ABSTATER_CRY_0,
    I0 => N_1,
    I1 => NN_2,
    CI => NN_1);
\FSM_TX.UN19_TX_ABSTATER_CRY_1_C\: SB_CARRY port map (
    CO => UN19_TX_ABSTATER_CRY_1,
    I0 => NN_2,
    I1 => N_2,
    CI => UN19_TX_ABSTATER_CRY_0);
\FSM_TX.UN19_TX_ABSTATER_CRY_2_C\: SB_CARRY port map (
    CO => UN19_TX_ABSTATER_CRY_2,
    I0 => NN_2,
    I1 => N_3,
    CI => UN19_TX_ABSTATER_CRY_1);
\FSM_TX.UN19_TX_ABSTATER_CRY_3_C\: SB_CARRY port map (
    CO => UN19_TX_ABSTATER,
    I0 => N_4,
    I1 => NN_1,
    CI => UN19_TX_ABSTATER_CRY_2);
UN1_TX_ABSTATER_1_CRY_1_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_1,
    I0 => TX_ABSTATER(1),
    I1 => NN_1,
    CI => TX_ABSTATER(0));
UN1_TX_ABSTATER_1_CRY_2_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_2,
    I0 => TX_ABSTATER(2),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_1);
UN1_TX_ABSTATER_1_CRY_3_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_3,
    I0 => TX_ABSTATER(3),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_2);
UN1_TX_ABSTATER_1_CRY_4_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_4,
    I0 => TX_ABSTATER(4),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_3);
UN1_TX_ABSTATER_1_CRY_5_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_5,
    I0 => TX_ABSTATER(5),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_4);
UN1_TX_ABSTATER_1_CRY_6_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_6,
    I0 => TX_ABSTATER(6),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_5);
UN1_TX_ABSTATER_1_CRY_7_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_7,
    I0 => TX_ABSTATER(7),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_6);
UN1_TX_ABSTATER_1_CRY_8_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_8,
    I0 => TX_ABSTATER(8),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_7);
UN1_TX_ABSTATER_1_CRY_9_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_9,
    I0 => TX_ABSTATER(9),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_8);
UN1_TX_ABSTATER_1_CRY_10_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_10,
    I0 => TX_ABSTATER(10),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_9);
UN1_TX_ABSTATER_1_CRY_11_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_11,
    I0 => TX_ABSTATER(11),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_10);
UN1_TX_ABSTATER_1_CRY_12_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_12,
    I0 => TX_ABSTATER(12),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_11);
UN1_TX_ABSTATER_1_CRY_13_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_13,
    I0 => TX_ABSTATER(13),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_12);
UN1_TX_ABSTATER_1_CRY_14_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_14,
    I0 => TX_ABSTATER(14),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_13);
UN1_TX_ABSTATER_1_CRY_15_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_15,
    I0 => TX_ABSTATER(15),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_14);
UN1_TX_ABSTATER_1_CRY_16_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_16,
    I0 => TX_ABSTATER(16),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_15);
UN1_TX_ABSTATER_1_CRY_17_C: SB_CARRY port map (
    CO => UN1_TX_ABSTATER_1_CRY_17,
    I0 => TX_ABSTATER(17),
    I1 => NN_1,
    CI => UN1_TX_ABSTATER_1_CRY_16);
UN3_TX_BIT_COUNTER_1_CRY_0_C: SB_CARRY port map (
    CO => UN3_TX_BIT_COUNTER_1_CRY_0,
    I0 => TX_BIT_COUNTER(0),
    I1 => NN_1,
    CI => TX_BIT_COUNTER_RNIRE5A8(3));
UN3_TX_BIT_COUNTER_1_CRY_1_C: SB_CARRY port map (
    CO => UN3_TX_BIT_COUNTER_1_CRY_1,
    I0 => TX_BIT_COUNTER(1),
    I1 => NN_1,
    CI => UN3_TX_BIT_COUNTER_1_CRY_0);
UN3_TX_BIT_COUNTER_1_CRY_2_C: SB_CARRY port map (
    CO => UN3_TX_BIT_COUNTER_1_CRY_2,
    I0 => TX_BIT_COUNTER(2),
    I1 => NN_1,
    CI => UN3_TX_BIT_COUNTER_1_CRY_1);
N_1 <= UN19_TX_ABSTATER_0_I;
N_2 <= TX_BIT_COUNTER_I(1);
N_3 <= TX_BIT_COUNTER_I(2);
N_4 <= UN19_TX_ABSTATER_AXB_3;
II_GND: GND port map (
    Y => NN_1);
II_VCC: VCC port map (
    Y => NN_2);
counter9_0 <= COUNTER9_12;
end beh;

--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--library synplify;
--use synplify.components.all;
library work;
use work.vcomponent_vital.all; 
use work.std_logic_SBT.all; 

entity receiver is
port(
rx_BinaryCode : out std_logic_vector(7 downto 0);
i_UART_RX_c :  in std_logic;
i_Clk_c_g :  in std_logic);
end receiver;

architecture beh of receiver is
signal FSM_STATE_RNIL21Q4_0 : std_logic_vector(0 to 0);
signal RX_BIT_COUNTER : std_logic_vector(3 downto 0);
signal FSM_STATE : std_logic_vector(1 downto 0);
signal NBR_STOPBITS_RNO_0 : std_logic_vector(1 to 1);
signal R_IN_SYNC : std_logic_vector(2 downto 0);
signal RX_BIT_ABSTATER : std_logic_vector(18 downto 0);
signal RX_BIT_ABSTATER_I : std_logic_vector(0 to 0);
signal RX_BIT_ABSTATER_RNO : std_logic_vector(18 downto 1);
signal N_96_G : std_logic ;
signal UN1_RX_BIT_COUNTER_1_CRY_2 : std_logic ;
signal RX_BIT_COUNTER_2 : std_logic ;
signal N_5 : std_logic ;
signal NN_1 : std_logic ;
signal NBR_STOPBITS : std_logic ;
signal NBR_STOPBITS_0 : std_logic ;
signal N_36 : std_logic ;
signal NN_2 : std_logic ;
signal NN_3 : std_logic ;
signal N_34 : std_logic ;
signal N_107 : std_logic ;
signal N_8 : std_logic ;
signal UN2_FSM_STATE_5_0_4 : std_logic ;
signal UN2_FSM_STATE_5_0_5 : std_logic ;
signal UN2_FSM_STATE_5_0 : std_logic ;
signal M8_I_A2_2_2 : std_logic ;
signal N_50 : std_logic ;
signal N_105 : std_logic ;
signal M8_I_O2_2 : std_logic ;
signal R_NUTZ_FRAME_0_SQMUXA_0_O2_6 : std_logic ;
signal R_NUTZ_FRAME_0_SQMUXA_0_O2_7 : std_logic ;
signal R_NUTZ_FRAME_0_SQMUXA_0_O2_8 : std_logic ;
signal R_NUTZ_FRAME_0_SQMUXA_0_O2_9 : std_logic ;
signal R_NUTZ_FRAME_0_SQMUXA : std_logic ;
signal M8_I_1 : std_logic ;
signal N_10 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_16 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_15 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_14 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_13 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_12 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_11 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_10 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_9 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_8 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_7 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_6 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_5 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_4 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_3 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_2 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_1 : std_logic ;
signal NN_6 : std_logic ;
signal UN1_RX_BIT_COUNTER_1_CRY_0 : std_logic ;
signal RX_BIT_COUNTER_0 : std_logic ;
signal UN1_RX_BIT_COUNTER_1_CRY_1 : std_logic ;
signal RX_BIT_COUNTER_1 : std_logic ;
signal UN1_RX_BIT_ABSTATER_1_CRY_17 : std_logic ;
signal NN_4 : std_logic ;
signal RX_BINARYCODE_6 : std_logic ;
signal RX_BINARYCODE_7 : std_logic ;
signal RX_BINARYCODE_8 : std_logic ;
signal RX_BINARYCODE_9 : std_logic ;
signal RX_BINARYCODE_10 : std_logic ;
signal RX_BINARYCODE_11 : std_logic ;
signal N_37 : std_logic ;
signal N_36_0 : std_logic ;
signal N_35 : std_logic ;
signal N_34_0 : std_logic ;
signal N_10_0 : std_logic ;
signal N_9 : std_logic ;
signal VCC_X : std_logic ;
signal NN_5 : std_logic ;
begin
\FSM_STATE_RNIL21Q4_1[0]\: SB_GB port map (
  GLOBAL_BUFFER_OUTPUT => N_96_G,
  USER_SIGNAL_TO_GLOBAL_BUFFER => FSM_STATE_RNIL21Q4_0(0));
\RX_BIT_COUNTER_RNO[3]\: SB_LUT4 
generic map(
  LUT_INIT => X"6660"
)
port map (
I0 => RX_BIT_COUNTER(3),
I1 => UN1_RX_BIT_COUNTER_1_CRY_2,
I2 => FSM_STATE(0),
I3 => FSM_STATE(1),
O => RX_BIT_COUNTER_2);
\NBR_STOPBITS_RNO[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"A8A8"
)
port map (
I0 => N_5,
I1 => FSM_STATE(0),
I2 => FSM_STATE(1),
I3 => NN_1,
O => NBR_STOPBITS);
\NBR_STOPBITS_RNO[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"5454"
)
port map (
I0 => NBR_STOPBITS_RNO_0(1),
I1 => FSM_STATE(0),
I2 => FSM_STATE(1),
I3 => NN_1,
O => NBR_STOPBITS_0);
\NBR_STOPBITS_RNO_0[1]_Z136\: SB_LUT4 
generic map(
  LUT_INIT => X"4B0B"
)
port map (
I0 => N_36,
I1 => NN_2,
I2 => NN_3,
I3 => R_IN_SYNC(1),
O => NBR_STOPBITS_RNO_0(1));
\NBR_STOPBITS_RNO_0[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"99C8"
)
port map (
I0 => N_36,
I1 => NN_2,
I2 => NN_3,
I3 => R_IN_SYNC(1),
O => N_5);
\FSM_STATE_NS_1_0_.M11_I\: SB_LUT4 
generic map(
  LUT_INIT => X"CFDC"
)
port map (
I0 => N_34,
I1 => N_107,
I2 => FSM_STATE(0),
I3 => FSM_STATE(1),
O => N_8);
\FSM_STATE_RNIL21Q4_0[0]_Z139\: SB_LUT4 
generic map(
  LUT_INIT => X"5757"
)
port map (
I0 => N_34,
I1 => FSM_STATE(0),
I2 => FSM_STATE(1),
I3 => NN_1,
O => FSM_STATE_RNIL21Q4_0(0));
\FSM_STATE_RNIL21Q4[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"BFBF"
)
port map (
I0 => N_34,
I1 => FSM_STATE(0),
I2 => FSM_STATE(1),
I3 => NN_1,
O => N_36);
\RX_BIT_ABSTATER_RNIJKPD4[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"8888"
)
port map (
I0 => UN2_FSM_STATE_5_0_4,
I1 => UN2_FSM_STATE_5_0_5,
I2 => NN_1,
I3 => NN_1,
O => UN2_FSM_STATE_5_0);
\FSM_STATE_NS_1_0_.M8_I_A2_2\: SB_LUT4 
generic map(
  LUT_INIT => X"1000"
)
port map (
I0 => N_34,
I1 => FSM_STATE(0),
I2 => FSM_STATE(1),
I3 => M8_I_A2_2_2,
O => N_50);
\RX_BIT_ABSTATER_RNI3TM24[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"1010"
)
port map (
I0 => N_105,
I1 => FSM_STATE(0),
I2 => RX_BIT_ABSTATER(1),
I3 => NN_1,
O => UN2_FSM_STATE_5_0_5);
\FSM_STATE_NS_1_0_.M8_I_O2\: SB_LUT4 
generic map(
  LUT_INIT => X"EFFF"
)
port map (
I0 => N_105,
I1 => M8_I_O2_2,
I2 => RX_BIT_ABSTATER(4),
I3 => RX_BIT_ABSTATER(7),
O => N_34);
\RX_BIT_ABSTATER_RNI9TMJ3[2]\: SB_LUT4 
generic map(
  LUT_INIT => X"FFFE"
)
port map (
I0 => R_NUTZ_FRAME_0_SQMUXA_0_O2_6,
I1 => R_NUTZ_FRAME_0_SQMUXA_0_O2_7,
I2 => R_NUTZ_FRAME_0_SQMUXA_0_O2_8,
I3 => R_NUTZ_FRAME_0_SQMUXA_0_O2_9,
O => N_105);
\FSM_STATE_NS_1_0_.M8_I_A2\: SB_LUT4 
generic map(
  LUT_INIT => X"8808"
)
port map (
I0 => FSM_STATE(0),
I1 => FSM_STATE(1),
I2 => NN_2,
I3 => NN_3,
O => N_107);
\RX_BIT_ABSTATER_RNIGN2B[4]\: SB_LUT4 
generic map(
  LUT_INIT => X"0020"
)
port map (
I0 => RX_BIT_ABSTATER(0),
I1 => RX_BIT_ABSTATER(4),
I2 => RX_BIT_ABSTATER(5),
I3 => RX_BIT_ABSTATER(7),
O => UN2_FSM_STATE_5_0_4);
\RX_BIT_ABSTATER_RNIKR2B[2]\: SB_LUT4 
generic map(
  LUT_INIT => X"FFBF"
)
port map (
I0 => RX_BIT_ABSTATER(2),
I1 => RX_BIT_ABSTATER(3),
I2 => RX_BIT_ABSTATER(6),
I3 => RX_BIT_ABSTATER(9),
O => R_NUTZ_FRAME_0_SQMUXA_0_O2_7);
\RX_BIT_ABSTATER_RNIAAN41[18]\: SB_LUT4 
generic map(
  LUT_INIT => X"FFFE"
)
port map (
I0 => RX_BIT_ABSTATER(8),
I1 => RX_BIT_ABSTATER(11),
I2 => RX_BIT_ABSTATER(16),
I3 => RX_BIT_ABSTATER(18),
O => R_NUTZ_FRAME_0_SQMUXA_0_O2_8);
\RX_BIT_ABSTATER_RNIEB8D1[10]\: SB_LUT4 
generic map(
  LUT_INIT => X"FFFE"
)
port map (
I0 => RX_BIT_ABSTATER(10),
I1 => RX_BIT_ABSTATER(12),
I2 => RX_BIT_ABSTATER(13),
I3 => RX_BIT_ABSTATER(15),
O => R_NUTZ_FRAME_0_SQMUXA_0_O2_9);
\FSM_STATE_NS_1_0_.M8_I_O2_2\: SB_LUT4 
generic map(
  LUT_INIT => X"FEFE"
)
port map (
I0 => RX_BIT_ABSTATER(0),
I1 => RX_BIT_ABSTATER(1),
I2 => RX_BIT_ABSTATER(5),
I3 => NN_1,
O => M8_I_O2_2);
\FSM_STATE_NS_1_0_.M8_I_A2_2_2\: SB_LUT4 
generic map(
  LUT_INIT => X"0100"
)
port map (
I0 => RX_BIT_COUNTER(0),
I1 => RX_BIT_COUNTER(1),
I2 => RX_BIT_COUNTER(2),
I3 => RX_BIT_COUNTER(3),
O => M8_I_A2_2_2);
\RX_BIT_ABSTATER_RNO[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"5555"
)
port map (
I0 => RX_BIT_ABSTATER(0),
I1 => NN_1,
I2 => NN_1,
I3 => NN_1,
O => RX_BIT_ABSTATER_I(0));
\RX_BIT_ABSTATER_RNITBKM[14]\: SB_LUT4 
generic map(
  LUT_INIT => X"EEEE"
)
port map (
I0 => RX_BIT_ABSTATER(14),
I1 => RX_BIT_ABSTATER(17),
I2 => NN_1,
I3 => NN_1,
O => R_NUTZ_FRAME_0_SQMUXA_0_O2_6);
\FSM_STATE_RNIL21Q4[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"8080"
)
port map (
I0 => FSM_STATE(1),
I1 => UN2_FSM_STATE_5_0_4,
I2 => UN2_FSM_STATE_5_0_5,
I3 => NN_1,
O => R_NUTZ_FRAME_0_SQMUXA);
\FSM_STATE_NS_1_0_.M8_I_1\: SB_LUT4 
generic map(
  LUT_INIT => X"7477"
)
port map (
I0 => N_34,
I1 => FSM_STATE(0),
I2 => R_IN_SYNC(1),
I3 => R_IN_SYNC(2),
O => M8_I_1);
\FSM_STATE_NS_1_0_.M8_I\: SB_LUT4 
generic map(
  LUT_INIT => X"EEEF"
)
port map (
I0 => N_50,
I1 => N_107,
I2 => FSM_STATE(1),
I3 => M8_I_1,
O => N_10);
\RX_BIT_ABSTATER_RNO[17]_Z158\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(17),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_16,
O => RX_BIT_ABSTATER_RNO(17));
\RX_BIT_ABSTATER_RNO[16]_Z159\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(16),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_15,
O => RX_BIT_ABSTATER_RNO(16));
\RX_BIT_ABSTATER_RNO[15]_Z160\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(15),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_14,
O => RX_BIT_ABSTATER_RNO(15));
\RX_BIT_ABSTATER_RNO[14]_Z161\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(14),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_13,
O => RX_BIT_ABSTATER_RNO(14));
\RX_BIT_ABSTATER_RNO[13]_Z162\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(13),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_12,
O => RX_BIT_ABSTATER_RNO(13));
\RX_BIT_ABSTATER_RNO[12]_Z163\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(12),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_11,
O => RX_BIT_ABSTATER_RNO(12));
\RX_BIT_ABSTATER_RNO[11]_Z164\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(11),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_10,
O => RX_BIT_ABSTATER_RNO(11));
\RX_BIT_ABSTATER_RNO[10]_Z165\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(10),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_9,
O => RX_BIT_ABSTATER_RNO(10));
\RX_BIT_ABSTATER_RNO[9]_Z166\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(9),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_8,
O => RX_BIT_ABSTATER_RNO(9));
\RX_BIT_ABSTATER_RNO[8]_Z167\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(8),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_7,
O => RX_BIT_ABSTATER_RNO(8));
\RX_BIT_ABSTATER_RNO[7]_Z168\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(7),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_6,
O => RX_BIT_ABSTATER_RNO(7));
\RX_BIT_ABSTATER_RNO[6]_Z169\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(6),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_5,
O => RX_BIT_ABSTATER_RNO(6));
\RX_BIT_ABSTATER_RNO[5]_Z170\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(5),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_4,
O => RX_BIT_ABSTATER_RNO(5));
\RX_BIT_ABSTATER_RNO[4]_Z171\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(4),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_3,
O => RX_BIT_ABSTATER_RNO(4));
\RX_BIT_ABSTATER_RNO[3]_Z172\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(3),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_2,
O => RX_BIT_ABSTATER_RNO(3));
\RX_BIT_ABSTATER_RNO[2]_Z173\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(2),
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_1,
O => RX_BIT_ABSTATER_RNO(2));
\RX_BIT_ABSTATER_RNO[1]_Z174\: SB_LUT4 
generic map(
  LUT_INIT => X"C33C"
)
port map (
I0 => NN_1,
I1 => RX_BIT_ABSTATER(1),
I2 => NN_1,
I3 => RX_BIT_ABSTATER(0),
O => RX_BIT_ABSTATER_RNO(1));
\RX_BIT_COUNTER_RNO[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"6660"
)
port map (
I0 => RX_BIT_COUNTER(0),
I1 => UN2_FSM_STATE_5_0,
I2 => FSM_STATE(0),
I3 => FSM_STATE(1),
O => NN_6);
\RX_BIT_COUNTER_RNO[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"6660"
)
port map (
I0 => RX_BIT_COUNTER(1),
I1 => UN1_RX_BIT_COUNTER_1_CRY_0,
I2 => FSM_STATE(0),
I3 => FSM_STATE(1),
O => RX_BIT_COUNTER_0);
\RX_BIT_COUNTER_RNO[2]\: SB_LUT4 
generic map(
  LUT_INIT => X"6660"
)
port map (
I0 => RX_BIT_COUNTER(2),
I1 => UN1_RX_BIT_COUNTER_1_CRY_1,
I2 => FSM_STATE(0),
I3 => FSM_STATE(1),
O => RX_BIT_COUNTER_1);
\RX_BIT_ABSTATER_RNO[18]_Z178\: SB_LUT4 
generic map(
  LUT_INIT => X"55AA"
)
port map (
I0 => RX_BIT_ABSTATER(18),
I1 => NN_1,
I2 => NN_1,
I3 => UN1_RX_BIT_ABSTATER_1_CRY_17,
O => RX_BIT_ABSTATER_RNO(18));
\R_NUTZ_FRAME[0]\: SB_DFFE port map (
  Q => rx_BinaryCode(0),
  D => NN_4,
  C => i_Clk_c_g,
  E => R_NUTZ_FRAME_0_SQMUXA);
\R_NUTZ_FRAME[1]\: SB_DFFE port map (
  Q => NN_4,
  D => RX_BINARYCODE_6,
  C => i_Clk_c_g,
  E => R_NUTZ_FRAME_0_SQMUXA);
\R_NUTZ_FRAME[2]\: SB_DFFE port map (
  Q => RX_BINARYCODE_6,
  D => RX_BINARYCODE_7,
  C => i_Clk_c_g,
  E => R_NUTZ_FRAME_0_SQMUXA);
\R_NUTZ_FRAME[3]\: SB_DFFE port map (
  Q => RX_BINARYCODE_7,
  D => RX_BINARYCODE_8,
  C => i_Clk_c_g,
  E => R_NUTZ_FRAME_0_SQMUXA);
\R_NUTZ_FRAME[4]\: SB_DFFE port map (
  Q => RX_BINARYCODE_8,
  D => RX_BINARYCODE_9,
  C => i_Clk_c_g,
  E => R_NUTZ_FRAME_0_SQMUXA);
\R_NUTZ_FRAME[5]\: SB_DFFE port map (
  Q => RX_BINARYCODE_9,
  D => RX_BINARYCODE_10,
  C => i_Clk_c_g,
  E => R_NUTZ_FRAME_0_SQMUXA);
\R_NUTZ_FRAME[6]\: SB_DFFE port map (
  Q => RX_BINARYCODE_10,
  D => RX_BINARYCODE_11,
  C => i_Clk_c_g,
  E => R_NUTZ_FRAME_0_SQMUXA);
\R_NUTZ_FRAME[7]\: SB_DFFE port map (
  Q => RX_BINARYCODE_11,
  D => R_IN_SYNC(1),
  C => i_Clk_c_g,
  E => R_NUTZ_FRAME_0_SQMUXA);
\RX_BIT_ABSTATER[0]_Z187\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(0),
  D => RX_BIT_ABSTATER_I(0),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[1]_Z188\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(1),
  D => RX_BIT_ABSTATER_RNO(1),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[2]_Z189\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(2),
  D => RX_BIT_ABSTATER_RNO(2),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[3]_Z190\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(3),
  D => RX_BIT_ABSTATER_RNO(3),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[4]_Z191\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(4),
  D => RX_BIT_ABSTATER_RNO(4),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[5]_Z192\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(5),
  D => RX_BIT_ABSTATER_RNO(5),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[6]_Z193\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(6),
  D => RX_BIT_ABSTATER_RNO(6),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[7]_Z194\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(7),
  D => RX_BIT_ABSTATER_RNO(7),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[8]_Z195\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(8),
  D => RX_BIT_ABSTATER_RNO(8),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[9]_Z196\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(9),
  D => RX_BIT_ABSTATER_RNO(9),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[10]_Z197\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(10),
  D => RX_BIT_ABSTATER_RNO(10),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[11]_Z198\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(11),
  D => RX_BIT_ABSTATER_RNO(11),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[12]_Z199\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(12),
  D => RX_BIT_ABSTATER_RNO(12),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[13]_Z200\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(13),
  D => RX_BIT_ABSTATER_RNO(13),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[14]_Z201\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(14),
  D => RX_BIT_ABSTATER_RNO(14),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[15]_Z202\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(15),
  D => RX_BIT_ABSTATER_RNO(15),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[16]_Z203\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(16),
  D => RX_BIT_ABSTATER_RNO(16),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[17]_Z204\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(17),
  D => RX_BIT_ABSTATER_RNO(17),
  C => i_Clk_c_g,
  R => N_96_G);
\RX_BIT_ABSTATER[18]_Z205\: SB_DFFSR port map (
  Q => RX_BIT_ABSTATER(18),
  D => RX_BIT_ABSTATER_RNO(18),
  C => i_Clk_c_g,
  R => N_96_G);
\R_IN_SYNC[0]_Z206\: SB_DFF port map (
  Q => R_IN_SYNC(0),
  D => i_UART_RX_c,
  C => i_Clk_c_g);
\R_IN_SYNC[1]_Z207\: SB_DFF port map (
  Q => R_IN_SYNC(1),
  D => R_IN_SYNC(0),
  C => i_Clk_c_g);
\R_IN_SYNC[2]_Z208\: SB_DFF port map (
  Q => R_IN_SYNC(2),
  D => R_IN_SYNC(1),
  C => i_Clk_c_g);
\FSM_STATE[0]_Z209\: SB_DFF port map (
  Q => FSM_STATE(0),
  D => N_10,
  C => i_Clk_c_g);
\FSM_STATE[1]_Z210\: SB_DFF port map (
  Q => FSM_STATE(1),
  D => N_8,
  C => i_Clk_c_g);
\RX_BIT_COUNTER[3]_Z211\: SB_DFF port map (
  Q => RX_BIT_COUNTER(3),
  D => RX_BIT_COUNTER_2,
  C => i_Clk_c_g);
\RX_BIT_COUNTER[2]_Z212\: SB_DFF port map (
  Q => RX_BIT_COUNTER(2),
  D => RX_BIT_COUNTER_1,
  C => i_Clk_c_g);
\RX_BIT_COUNTER[1]_Z213\: SB_DFF port map (
  Q => RX_BIT_COUNTER(1),
  D => RX_BIT_COUNTER_0,
  C => i_Clk_c_g);
\RX_BIT_COUNTER[0]_Z214\: SB_DFF port map (
  Q => RX_BIT_COUNTER(0),
  D => NN_6,
  C => i_Clk_c_g);
\NBR_STOPBITS[1]\: SB_DFF port map (
  Q => NN_3,
  D => NBR_STOPBITS_0,
  C => i_Clk_c_g);
\NBR_STOPBITS[0]\: SB_DFF port map (
  Q => NN_2,
  D => NBR_STOPBITS,
  C => i_Clk_c_g);
UN1_RX_BIT_ABSTATER_1_CRY_1_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_1,
  I0 => RX_BIT_ABSTATER(1),
  I1 => NN_1,
  CI => RX_BIT_ABSTATER(0));
UN1_RX_BIT_ABSTATER_1_CRY_2_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_2,
  I0 => RX_BIT_ABSTATER(2),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_1);
UN1_RX_BIT_ABSTATER_1_CRY_3_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_3,
  I0 => RX_BIT_ABSTATER(3),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_2);
UN1_RX_BIT_ABSTATER_1_CRY_4_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_4,
  I0 => RX_BIT_ABSTATER(4),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_3);
UN1_RX_BIT_ABSTATER_1_CRY_5_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_5,
  I0 => RX_BIT_ABSTATER(5),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_4);
UN1_RX_BIT_ABSTATER_1_CRY_6_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_6,
  I0 => RX_BIT_ABSTATER(6),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_5);
UN1_RX_BIT_ABSTATER_1_CRY_7_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_7,
  I0 => RX_BIT_ABSTATER(7),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_6);
UN1_RX_BIT_ABSTATER_1_CRY_8_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_8,
  I0 => RX_BIT_ABSTATER(8),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_7);
UN1_RX_BIT_ABSTATER_1_CRY_9_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_9,
  I0 => RX_BIT_ABSTATER(9),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_8);
UN1_RX_BIT_ABSTATER_1_CRY_10_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_10,
  I0 => RX_BIT_ABSTATER(10),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_9);
UN1_RX_BIT_ABSTATER_1_CRY_11_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_11,
  I0 => RX_BIT_ABSTATER(11),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_10);
UN1_RX_BIT_ABSTATER_1_CRY_12_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_12,
  I0 => RX_BIT_ABSTATER(12),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_11);
UN1_RX_BIT_ABSTATER_1_CRY_13_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_13,
  I0 => RX_BIT_ABSTATER(13),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_12);
UN1_RX_BIT_ABSTATER_1_CRY_14_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_14,
  I0 => RX_BIT_ABSTATER(14),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_13);
UN1_RX_BIT_ABSTATER_1_CRY_15_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_15,
  I0 => RX_BIT_ABSTATER(15),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_14);
UN1_RX_BIT_ABSTATER_1_CRY_16_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_16,
  I0 => RX_BIT_ABSTATER(16),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_15);
UN1_RX_BIT_ABSTATER_1_CRY_17_C: SB_CARRY port map (
  CO => UN1_RX_BIT_ABSTATER_1_CRY_17,
  I0 => RX_BIT_ABSTATER(17),
  I1 => NN_1,
  CI => UN1_RX_BIT_ABSTATER_1_CRY_16);
UN1_RX_BIT_COUNTER_1_CRY_0_C: SB_CARRY port map (
  CO => UN1_RX_BIT_COUNTER_1_CRY_0,
  I0 => RX_BIT_COUNTER(0),
  I1 => NN_1,
  CI => UN2_FSM_STATE_5_0);
UN1_RX_BIT_COUNTER_1_CRY_1_C: SB_CARRY port map (
  CO => UN1_RX_BIT_COUNTER_1_CRY_1,
  I0 => RX_BIT_COUNTER(1),
  I1 => NN_1,
  CI => UN1_RX_BIT_COUNTER_1_CRY_0);
UN1_RX_BIT_COUNTER_1_CRY_2_C: SB_CARRY port map (
  CO => UN1_RX_BIT_COUNTER_1_CRY_2,
  I0 => RX_BIT_COUNTER(2),
  I1 => NN_1,
  CI => UN1_RX_BIT_COUNTER_1_CRY_1);
II_GND: GND port map (
  Y => NN_1);
II_VCC: VCC port map (
  Y => NN_5);
rx_BinaryCode(1) <= NN_4;
rx_BinaryCode(2) <= RX_BINARYCODE_6;
rx_BinaryCode(3) <= RX_BINARYCODE_7;
rx_BinaryCode(4) <= RX_BINARYCODE_8;
rx_BinaryCode(5) <= RX_BINARYCODE_9;
rx_BinaryCode(6) <= RX_BINARYCODE_10;
rx_BinaryCode(7) <= RX_BINARYCODE_11;
end beh;

--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--library synplify;
--use synplify.components.all;
library work;
use work.vcomponent_vital.all; 
use work.std_logic_SBT.all; 

entity DebounceUnit is
port(
sw1_c :  in std_logic;
i_Clk_c_g :  in std_logic;
sw1Debounced :  out std_logic);
end DebounceUnit;

architecture beh of DebounceUnit is
signal R_INPUTSYNC : std_logic_vector(1 downto 0);
signal R_DBOUNCECOUNTER : std_logic_vector(16 downto 0);
signal R_DBOUNCECOUNTER_I : std_logic_vector(0 to 0);
signal R_DBOUNCECOUNTER_RNO : std_logic_vector(16 downto 1);
signal R_DBOUNCECOUNTER15_I_G : std_logic ;
signal R_DBOUNCECOUNTER15_I : std_logic ;
signal UN1_R_DBOUNCECOUNTERLT16 : std_logic ;
signal UN1_R_DBOUNCECOUNTERLTO16_1 : std_logic ;
signal SW1DEBOUNCED_4 : std_logic ;
signal UN1_R_DBOUNCECOUNTERLT10_0 : std_logic ;
signal UN1_R_DBOUNCECOUNTERLTO10_1 : std_logic ;
signal UN8_R_DBOUNCECOUNTER_8 : std_logic ;
signal UN8_R_DBOUNCECOUNTER_9_2 : std_logic ;
signal R_DBOUNCED : std_logic ;
signal UN1_R_DBOUNCECOUNTERLTO5_0 : std_logic ;
signal UN8_R_DBOUNCECOUNTER_9 : std_logic ;
signal UN8_R_DBOUNCECOUNTER_4_0 : std_logic ;
signal UN8_R_DBOUNCECOUNTER_2 : std_logic ;
signal UN8_R_DBOUNCECOUNTER_5 : std_logic ;
signal NN_1 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_14 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_13 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_12 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_11 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_10 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_9 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_8 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_7 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_6 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_5 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_4 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_3 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_2 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_1 : std_logic ;
signal UN1_R_DBOUNCECOUNTER_CRY_15 : std_logic ;
signal VCC_X : std_logic ;
signal NN_2 : std_logic ;
begin
\R_INPUTSYNC_RNID7BV1_0[1]\: SB_GB port map (
GLOBAL_BUFFER_OUTPUT => R_DBOUNCECOUNTER15_I_G,
USER_SIGNAL_TO_GLOBAL_BUFFER => R_DBOUNCECOUNTER15_I);
\R_INPUTSYNC_RNID7BV1[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"F44F"
)
port map (
I0 => UN1_R_DBOUNCECOUNTERLT16,
I1 => UN1_R_DBOUNCECOUNTERLTO16_1,
I2 => R_INPUTSYNC(1),
I3 => SW1DEBOUNCED_4,
O => R_DBOUNCECOUNTER15_I);
\R_DBOUNCECOUNTER_RNIFO821[11]\: SB_LUT4 
generic map(
  LUT_INIT => X"004F"
)
port map (
I0 => UN1_R_DBOUNCECOUNTERLT10_0,
I1 => UN1_R_DBOUNCECOUNTERLTO10_1,
I2 => R_DBOUNCECOUNTER(11),
I3 => R_DBOUNCECOUNTER(12),
O => UN1_R_DBOUNCECOUNTERLT16);
R_DBOUNCED_RNO: SB_LUT4 
generic map(
  LUT_INIT => X"F780"
)
port map (
I0 => UN8_R_DBOUNCECOUNTER_8,
I1 => UN8_R_DBOUNCECOUNTER_9_2,
I2 => R_INPUTSYNC(1),
I3 => SW1DEBOUNCED_4,
O => R_DBOUNCED);
\R_DBOUNCECOUNTER_RNI3DFG[3]\: SB_LUT4 
generic map(
  LUT_INIT => X"FD00"
)
port map (
I0 => UN1_R_DBOUNCECOUNTERLTO5_0,
I1 => UN8_R_DBOUNCECOUNTER_9,
I2 => R_DBOUNCECOUNTER(3),
I3 => R_DBOUNCECOUNTER(6),
O => UN1_R_DBOUNCECOUNTERLT10_0);
R_DBOUNCED_RNO_1: SB_LUT4 
generic map(
  LUT_INIT => X"8000"
)
port map (
I0 => UN8_R_DBOUNCECOUNTER_4_0,
I1 => UN8_R_DBOUNCECOUNTER_9,
I2 => R_DBOUNCECOUNTER(14),
I3 => R_DBOUNCECOUNTER(15),
O => UN8_R_DBOUNCECOUNTER_9_2);
R_DBOUNCED_RNO_0: SB_LUT4 
generic map(
  LUT_INIT => X"0800"
)
port map (
I0 => UN8_R_DBOUNCECOUNTER_2,
I1 => UN8_R_DBOUNCECOUNTER_5,
I2 => R_DBOUNCECOUNTER(12),
I3 => R_DBOUNCECOUNTER(13),
O => UN8_R_DBOUNCECOUNTER_8);
\R_DBOUNCECOUNTER_RNITH78[1]\: SB_LUT4 
generic map(
  LUT_INIT => X"8000"
)
port map (
I0 => R_DBOUNCECOUNTER(0),
I1 => R_DBOUNCECOUNTER(1),
I2 => R_DBOUNCECOUNTER(2),
I3 => R_DBOUNCECOUNTER(6),
O => UN8_R_DBOUNCECOUNTER_9);
R_DBOUNCED_RNO_4: SB_LUT4 
generic map(
  LUT_INIT => X"1010"
)
port map (
I0 => R_DBOUNCECOUNTER(3),
I1 => R_DBOUNCECOUNTER(4),
I2 => R_DBOUNCECOUNTER(11),
I3 => NN_1,
O => UN8_R_DBOUNCECOUNTER_4_0);
R_DBOUNCED_RNO_3: SB_LUT4 
generic map(
  LUT_INIT => X"0100"
)
port map (
I0 => R_DBOUNCECOUNTER(5),
I1 => R_DBOUNCECOUNTER(7),
I2 => R_DBOUNCECOUNTER(10),
I3 => R_DBOUNCECOUNTER(16),
O => UN8_R_DBOUNCECOUNTER_5);
\R_DBOUNCECOUNTER_RNIA9FF[16]\: SB_LUT4 
generic map(
  LUT_INIT => X"8000"
)
port map (
I0 => R_DBOUNCECOUNTER(13),
I1 => R_DBOUNCECOUNTER(14),
I2 => R_DBOUNCECOUNTER(15),
I3 => R_DBOUNCECOUNTER(16),
O => UN1_R_DBOUNCECOUNTERLTO16_1);
\R_DBOUNCECOUNTER_RNO[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"5555"
)
port map (
I0 => R_DBOUNCECOUNTER(0),
I1 => NN_1,
I2 => NN_1,
I3 => NN_1,
O => R_DBOUNCECOUNTER_I(0));
R_DBOUNCED_RNO_2: SB_LUT4 
generic map(
  LUT_INIT => X"1111"
)
port map (
I0 => R_DBOUNCECOUNTER(8),
I1 => R_DBOUNCECOUNTER(9),
I2 => NN_1,
I3 => NN_1,
O => UN8_R_DBOUNCECOUNTER_2);
\R_DBOUNCECOUNTER_RNIJT34[4]\: SB_LUT4 
generic map(
  LUT_INIT => X"1111"
)
port map (
I0 => R_DBOUNCECOUNTER(4),
I1 => R_DBOUNCECOUNTER(5),
I2 => NN_1,
I3 => NN_1,
O => UN1_R_DBOUNCECOUNTERLTO5_0);
\R_DBOUNCECOUNTER_RNITS1A[7]\: SB_LUT4 
generic map(
  LUT_INIT => X"0001"
)
port map (
I0 => R_DBOUNCECOUNTER(10),
I1 => R_DBOUNCECOUNTER(7),
I2 => R_DBOUNCECOUNTER(9),
I3 => R_DBOUNCECOUNTER(8),
O => UN1_R_DBOUNCECOUNTERLTO10_1);
\R_DBOUNCECOUNTER_RNO[15]_Z91\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(15),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_14,
O => R_DBOUNCECOUNTER_RNO(15));
\R_DBOUNCECOUNTER_RNO[14]_Z92\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(14),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_13,
O => R_DBOUNCECOUNTER_RNO(14));
\R_DBOUNCECOUNTER_RNO[13]_Z93\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(13),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_12,
O => R_DBOUNCECOUNTER_RNO(13));
\R_DBOUNCECOUNTER_RNO[12]_Z94\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(12),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_11,
O => R_DBOUNCECOUNTER_RNO(12));
\R_DBOUNCECOUNTER_RNO[11]_Z95\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(11),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_10,
O => R_DBOUNCECOUNTER_RNO(11));
\R_DBOUNCECOUNTER_RNO[10]_Z96\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(10),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_9,
O => R_DBOUNCECOUNTER_RNO(10));
\R_DBOUNCECOUNTER_RNO[9]_Z97\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(9),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_8,
O => R_DBOUNCECOUNTER_RNO(9));
\R_DBOUNCECOUNTER_RNO[8]_Z98\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(8),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_7,
O => R_DBOUNCECOUNTER_RNO(8));
\R_DBOUNCECOUNTER_RNO[7]_Z99\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(7),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_6,
O => R_DBOUNCECOUNTER_RNO(7));
\R_DBOUNCECOUNTER_RNO[6]_Z100\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(6),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_5,
O => R_DBOUNCECOUNTER_RNO(6));
\R_DBOUNCECOUNTER_RNO[5]_Z101\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(5),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_4,
O => R_DBOUNCECOUNTER_RNO(5));
\R_DBOUNCECOUNTER_RNO[4]_Z102\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(4),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_3,
O => R_DBOUNCECOUNTER_RNO(4));
\R_DBOUNCECOUNTER_RNO[3]_Z103\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(3),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_2,
O => R_DBOUNCECOUNTER_RNO(3));
\R_DBOUNCECOUNTER_RNO[2]_Z104\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(2),
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_1,
O => R_DBOUNCECOUNTER_RNO(2));
\R_DBOUNCECOUNTER_RNO[1]_Z105\: SB_LUT4 
generic map(
  LUT_INIT => X"C33C"
)
port map (
I0 => NN_1,
I1 => R_DBOUNCECOUNTER(1),
I2 => NN_1,
I3 => R_DBOUNCECOUNTER(0),
O => R_DBOUNCECOUNTER_RNO(1));
\R_DBOUNCECOUNTER_RNO[16]_Z106\: SB_LUT4 
generic map(
  LUT_INIT => X"55AA"
)
port map (
I0 => R_DBOUNCECOUNTER(16),
I1 => NN_1,
I2 => NN_1,
I3 => UN1_R_DBOUNCECOUNTER_CRY_15,
O => R_DBOUNCECOUNTER_RNO(16));
R_DBOUNCED_Z107: SB_DFF port map (
Q => SW1DEBOUNCED_4,
D => R_DBOUNCED,
C => i_Clk_c_g);
\R_DBOUNCECOUNTER[0]_Z108\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(0),
D => R_DBOUNCECOUNTER_I(0),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[1]_Z109\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(1),
D => R_DBOUNCECOUNTER_RNO(1),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[2]_Z110\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(2),
D => R_DBOUNCECOUNTER_RNO(2),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[3]_Z111\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(3),
D => R_DBOUNCECOUNTER_RNO(3),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[4]_Z112\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(4),
D => R_DBOUNCECOUNTER_RNO(4),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[5]_Z113\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(5),
D => R_DBOUNCECOUNTER_RNO(5),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[6]_Z114\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(6),
D => R_DBOUNCECOUNTER_RNO(6),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[7]_Z115\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(7),
D => R_DBOUNCECOUNTER_RNO(7),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[8]_Z116\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(8),
D => R_DBOUNCECOUNTER_RNO(8),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[9]_Z117\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(9),
D => R_DBOUNCECOUNTER_RNO(9),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[10]_Z118\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(10),
D => R_DBOUNCECOUNTER_RNO(10),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[11]_Z119\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(11),
D => R_DBOUNCECOUNTER_RNO(11),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[12]_Z120\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(12),
D => R_DBOUNCECOUNTER_RNO(12),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[13]_Z121\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(13),
D => R_DBOUNCECOUNTER_RNO(13),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[14]_Z122\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(14),
D => R_DBOUNCECOUNTER_RNO(14),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[15]_Z123\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(15),
D => R_DBOUNCECOUNTER_RNO(15),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_DBOUNCECOUNTER[16]_Z124\: SB_DFFSR port map (
Q => R_DBOUNCECOUNTER(16),
D => R_DBOUNCECOUNTER_RNO(16),
C => i_Clk_c_g,
R => R_DBOUNCECOUNTER15_I_G);
\R_INPUTSYNC[0]_Z125\: SB_DFF port map (
Q => R_INPUTSYNC(0),
D => sw1_c,
C => i_Clk_c_g);
\R_INPUTSYNC[1]_Z126\: SB_DFF port map (
Q => R_INPUTSYNC(1),
D => R_INPUTSYNC(0),
C => i_Clk_c_g);
UN1_R_DBOUNCECOUNTER_CRY_1_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_1,
I0 => R_DBOUNCECOUNTER(1),
I1 => NN_1,
CI => R_DBOUNCECOUNTER(0));
UN1_R_DBOUNCECOUNTER_CRY_2_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_2,
I0 => R_DBOUNCECOUNTER(2),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_1);
UN1_R_DBOUNCECOUNTER_CRY_3_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_3,
I0 => R_DBOUNCECOUNTER(3),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_2);
UN1_R_DBOUNCECOUNTER_CRY_4_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_4,
I0 => R_DBOUNCECOUNTER(4),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_3);
UN1_R_DBOUNCECOUNTER_CRY_5_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_5,
I0 => R_DBOUNCECOUNTER(5),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_4);
UN1_R_DBOUNCECOUNTER_CRY_6_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_6,
I0 => R_DBOUNCECOUNTER(6),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_5);
UN1_R_DBOUNCECOUNTER_CRY_7_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_7,
I0 => R_DBOUNCECOUNTER(7),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_6);
UN1_R_DBOUNCECOUNTER_CRY_8_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_8,
I0 => R_DBOUNCECOUNTER(8),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_7);
UN1_R_DBOUNCECOUNTER_CRY_9_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_9,
I0 => R_DBOUNCECOUNTER(9),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_8);
UN1_R_DBOUNCECOUNTER_CRY_10_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_10,
I0 => R_DBOUNCECOUNTER(10),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_9);
UN1_R_DBOUNCECOUNTER_CRY_11_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_11,
I0 => R_DBOUNCECOUNTER(11),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_10);
UN1_R_DBOUNCECOUNTER_CRY_12_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_12,
I0 => R_DBOUNCECOUNTER(12),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_11);
UN1_R_DBOUNCECOUNTER_CRY_13_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_13,
I0 => R_DBOUNCECOUNTER(13),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_12);
UN1_R_DBOUNCECOUNTER_CRY_14_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_14,
I0 => R_DBOUNCECOUNTER(14),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_13);
UN1_R_DBOUNCECOUNTER_CRY_15_C: SB_CARRY port map (
CO => UN1_R_DBOUNCECOUNTER_CRY_15,
I0 => R_DBOUNCECOUNTER(15),
I1 => NN_1,
CI => UN1_R_DBOUNCECOUNTER_CRY_14);
II_GND: GND port map (
Y => NN_1);
II_VCC: VCC port map (
Y => NN_2);
sw1Debounced <= SW1DEBOUNCED_4;
end beh;

--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--library synplify;
--use synplify.components.all;
library work;
use work.vcomponent_vital.all; 
use work.std_logic_SBT.all; 

entity uart_2_7_seg_display is
port(
i_Clk :  in std_logic;
sw1 :  in std_logic;
i_UART_RX :  in std_logic;
o_UART_TX :  out std_logic;
o_Segment1_A :  out std_logic;
o_Segment1_B :  out std_logic;
o_Segment1_C :  out std_logic;
o_Segment1_D :  out std_logic;
o_Segment1_E :  out std_logic;
o_Segment1_F :  out std_logic;
o_Segment1_G :  out std_logic;
o_Segment2_A :  out std_logic;
o_Segment2_B :  out std_logic;
o_Segment2_C :  out std_logic;
o_Segment2_D :  out std_logic;
o_Segment2_E :  out std_logic;
o_Segment2_F :  out std_logic;
o_Segment2_G :  out std_logic);
end uart_2_7_seg_display;

architecture beh of uart_2_7_seg_display is
signal RX_BINARYCODE : std_logic_vector(7 downto 0);
signal TX_BINARYCODE : std_logic_vector(7 downto 0);
signal COUNTER : std_logic_vector(10 downto 0);
signal COUNTER_RNO : std_logic_vector(10 downto 1);
signal COUNTER_I : std_logic_vector(0 to 0);
signal SEGMENT1CODE_I : std_logic_vector(6 downto 0);
signal SEGMENT2CODE_I : std_logic_vector(6 downto 0);
signal SEGMENT2CODE_2_I : std_logic_vector(5 downto 3);
signal SW1DEBOUNCED : std_logic ;
signal NN_1 : std_logic ;
signal \PARALLIZING.UN14_COUNTER\ : std_logic ;
signal NN_2 : std_logic ;
signal M5 : std_logic ;
signal M10 : std_logic ;
signal M14 : std_logic ;
signal M26 : std_logic ;
signal M26_0 : std_logic ;
signal \PARALLIZING.COUNTER9_0\ : std_logic ;
signal N_9 : std_logic ;
signal N_12 : std_logic ;
signal N_14 : std_logic ;
signal I_CLK_INTERNAL : std_logic ;
signal SW1_C : std_logic ;
signal SW1_INTERNAL : std_logic ;
signal I_UART_RX_C : std_logic ;
signal I_UART_RX_INTERNAL : std_logic ;
signal O_UART_TX_C : std_logic ;
signal O_UART_TX_13 : std_logic ;
signal O_SEGMENT1_A_14 : std_logic ;
signal O_SEGMENT1_B_15 : std_logic ;
signal O_SEGMENT1_C_16 : std_logic ;
signal O_SEGMENT1_D_17 : std_logic ;
signal O_SEGMENT1_E_18 : std_logic ;
signal O_SEGMENT1_F_19 : std_logic ;
signal O_SEGMENT1_G_20 : std_logic ;
signal O_SEGMENT2_A_21 : std_logic ;
signal O_SEGMENT2_B_22 : std_logic ;
signal O_SEGMENT2_C_23 : std_logic ;
signal O_SEGMENT2_D_24 : std_logic ;
signal O_SEGMENT2_E_25 : std_logic ;
signal O_SEGMENT2_F_26 : std_logic ;
signal O_SEGMENT2_G_27 : std_logic ;
signal UN2_COUNTER_CRY_1 : std_logic ;
signal UN2_COUNTER_CRY_2 : std_logic ;
signal UN2_COUNTER_CRY_3 : std_logic ;
signal UN2_COUNTER_CRY_4 : std_logic ;
signal UN2_COUNTER_CRY_5 : std_logic ;
signal UN2_COUNTER_CRY_6 : std_logic ;
signal UN2_COUNTER_CRY_7 : std_logic ;
signal UN2_COUNTER_CRY_8 : std_logic ;
signal UN2_COUNTER_CRY_9 : std_logic ;
signal N_16_I : std_logic ;
signal N_18_I : std_logic ;
signal N_20_I : std_logic ;
signal I_CLK_C_G : std_logic ;
signal N_1 : std_logic ;
signal N_2 : std_logic ;
signal N_3 : std_logic ;
signal N_4 : std_logic ;
signal N_5 : std_logic ;
signal N_6 : std_logic ;
signal N_7 : std_logic ;
signal N_8 : std_logic ;
signal N_10 : std_logic ;
signal N_11 : std_logic ;
signal N_13 : std_logic ;
signal N_15 : std_logic ;
signal N_16 : std_logic ;
signal N_17 : std_logic ;
signal N_18 : std_logic ;
signal N_19 : std_logic ;
signal N_20 : std_logic ;
signal N_21 : std_logic ;
signal N_22 : std_logic ;
signal N_23 : std_logic ;
signal N_24 : std_logic ;
signal N_25 : std_logic ;
signal N_26 : std_logic ;
signal N_27 : std_logic ;
signal N_28 : std_logic ;
signal N_29 : std_logic ;
signal N_30 : std_logic ;
signal N_31 : std_logic ;
signal N_32 : std_logic ;
signal N_33 : std_logic ;
signal N_34 : std_logic ;
signal N_35 : std_logic ;
signal N_36 : std_logic ;
signal N_37 : std_logic ;
component DebounceUnit
port(
sw1_c :  in std_logic;
i_Clk_c_g :  in std_logic;
sw1Debounced :  out std_logic  );
end component;
component receiver
port(
rx_BinaryCode : out std_logic_vector(7 downto 0);
i_UART_RX_c :  in std_logic;
i_Clk_c_g :  in std_logic  );
end component;
component transmitter
port(
counter : in std_logic_vector(10 downto 0);
tx_BinaryCode : in std_logic_vector(7 downto 0);
rx_BinaryCode : in std_logic_vector(7 downto 0);
o_UART_TX_c :  out std_logic;
i_Clk_c_g :  in std_logic;
un14_counter :  out std_logic;
counter9_0 :  out std_logic  );
end component;
begin
I_CLK_IBUF_GB_IO: SB_GB_IO 
generic map(
  PIN_TYPE => "000001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => I_CLK_INTERNAL,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => NN_2,
D_IN_1 => N_1,
D_IN_0 => N_2,
GLOBAL_BUFFER_OUTPUT => I_CLK_C_G);
\SEGMENT1CODE_18_6_0_.N_20_I\: SB_LUT4 
generic map(
  LUT_INIT => X"1083"
)
port map (
I0 => RX_BINARYCODE(4),
I1 => RX_BINARYCODE(5),
I2 => RX_BINARYCODE(6),
I3 => RX_BINARYCODE(7),
O => N_20_I);
\SEGMENT2CODE_2_6_0_.SEGMENT2CODE_2_I[5]\: SB_LUT4 
generic map(
  LUT_INIT => X"D860"
)
port map (
I0 => RX_BINARYCODE(0),
I1 => RX_BINARYCODE(1),
I2 => RX_BINARYCODE(2),
I3 => RX_BINARYCODE(3),
O => SEGMENT2CODE_2_I(5));
\SEGMENT2CODE_2_6_0_.SEGMENT2CODE_2_I[4]\: SB_LUT4 
generic map(
  LUT_INIT => X"D004"
)
port map (
I0 => RX_BINARYCODE(0),
I1 => RX_BINARYCODE(1),
I2 => RX_BINARYCODE(2),
I3 => RX_BINARYCODE(3),
O => SEGMENT2CODE_2_I(4));
\SEGMENT2CODE_2_6_0_.SEGMENT2CODE_2_I[3]\: SB_LUT4 
generic map(
  LUT_INIT => X"8492"
)
port map (
I0 => RX_BINARYCODE(0),
I1 => RX_BINARYCODE(1),
I2 => RX_BINARYCODE(2),
I3 => RX_BINARYCODE(3),
O => SEGMENT2CODE_2_I(3));
\SEGMENT2CODE_2_6_0_.M26\: SB_LUT4 
generic map(
  LUT_INIT => X"2812"
)
port map (
I0 => RX_BINARYCODE(0),
I1 => RX_BINARYCODE(1),
I2 => RX_BINARYCODE(2),
I3 => RX_BINARYCODE(3),
O => M26);
\SEGMENT2CODE_2_6_0_.M14\: SB_LUT4 
generic map(
  LUT_INIT => X"02BA"
)
port map (
I0 => RX_BINARYCODE(0),
I1 => RX_BINARYCODE(1),
I2 => RX_BINARYCODE(2),
I3 => RX_BINARYCODE(3),
O => M14);
\SEGMENT2CODE_2_6_0_.M10\: SB_LUT4 
generic map(
  LUT_INIT => X"208E"
)
port map (
I0 => RX_BINARYCODE(0),
I1 => RX_BINARYCODE(1),
I2 => RX_BINARYCODE(2),
I3 => RX_BINARYCODE(3),
O => M10);
\SEGMENT2CODE_2_6_0_.M5\: SB_LUT4 
generic map(
  LUT_INIT => X"1083"
)
port map (
I0 => RX_BINARYCODE(0),
I1 => RX_BINARYCODE(1),
I2 => RX_BINARYCODE(2),
I3 => RX_BINARYCODE(3),
O => M5);
\SEGMENT1CODE_18_6_0_.M26_0\: SB_LUT4 
generic map(
  LUT_INIT => X"2812"
)
port map (
I0 => RX_BINARYCODE(4),
I1 => RX_BINARYCODE(5),
I2 => RX_BINARYCODE(6),
I3 => RX_BINARYCODE(7),
O => M26_0);
\SEGMENT1CODE_18_6_0_.N_16_I\: SB_LUT4 
generic map(
  LUT_INIT => X"02BA"
)
port map (
I0 => RX_BINARYCODE(4),
I1 => RX_BINARYCODE(5),
I2 => RX_BINARYCODE(6),
I3 => RX_BINARYCODE(7),
O => N_16_I);
\SEGMENT1CODE_18_6_0_.N_18_I\: SB_LUT4 
generic map(
  LUT_INIT => X"208E"
)
port map (
I0 => RX_BINARYCODE(4),
I1 => RX_BINARYCODE(5),
I2 => RX_BINARYCODE(6),
I3 => RX_BINARYCODE(7),
O => N_18_I);
\SEGMENT1CODE_18_6_0_.M23_I\: SB_LUT4 
generic map(
  LUT_INIT => X"D860"
)
port map (
I0 => RX_BINARYCODE(4),
I1 => RX_BINARYCODE(5),
I2 => RX_BINARYCODE(6),
I3 => RX_BINARYCODE(7),
O => N_12);
\SEGMENT1CODE_18_6_0_.M17_I\: SB_LUT4 
generic map(
  LUT_INIT => X"8492"
)
port map (
I0 => RX_BINARYCODE(4),
I1 => RX_BINARYCODE(5),
I2 => RX_BINARYCODE(6),
I3 => RX_BINARYCODE(7),
O => N_9);
\SEGMENT1CODE_18_6_0_.M20_I\: SB_LUT4 
generic map(
  LUT_INIT => X"D004"
)
port map (
I0 => RX_BINARYCODE(4),
I1 => RX_BINARYCODE(5),
I2 => RX_BINARYCODE(6),
I3 => RX_BINARYCODE(7),
O => N_14);
\COUNTER_RNO[0]\: SB_LUT4 
generic map(
  LUT_INIT => X"5555"
)
port map (
I0 => COUNTER(0),
I1 => NN_2,
I2 => NN_2,
I3 => NN_2,
O => COUNTER_I(0));
\COUNTER_RNO[9]_Z178\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_2,
I1 => COUNTER(9),
I2 => NN_2,
I3 => UN2_COUNTER_CRY_8,
O => COUNTER_RNO(9));
\COUNTER_RNO[8]_Z179\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_2,
I1 => COUNTER(8),
I2 => NN_2,
I3 => UN2_COUNTER_CRY_7,
O => COUNTER_RNO(8));
\COUNTER_RNO[7]_Z180\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_2,
I1 => COUNTER(7),
I2 => NN_2,
I3 => UN2_COUNTER_CRY_6,
O => COUNTER_RNO(7));
\COUNTER_RNO[6]_Z181\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_2,
I1 => COUNTER(6),
I2 => NN_2,
I3 => UN2_COUNTER_CRY_5,
O => COUNTER_RNO(6));
\COUNTER_RNO[5]_Z182\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_2,
I1 => COUNTER(5),
I2 => NN_2,
I3 => UN2_COUNTER_CRY_4,
O => COUNTER_RNO(5));
\COUNTER_RNO[4]_Z183\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_2,
I1 => COUNTER(4),
I2 => NN_2,
I3 => UN2_COUNTER_CRY_3,
O => COUNTER_RNO(4));
\COUNTER_RNO[3]_Z184\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_2,
I1 => COUNTER(3),
I2 => NN_2,
I3 => UN2_COUNTER_CRY_2,
O => COUNTER_RNO(3));
\COUNTER_RNO[2]_Z185\: SB_LUT4 
generic map(
  LUT_INIT => X"9966"
)
port map (
I0 => NN_2,
I1 => COUNTER(2),
I2 => NN_2,
I3 => UN2_COUNTER_CRY_1,
O => COUNTER_RNO(2));
\COUNTER_RNO[1]_Z186\: SB_LUT4 
generic map(
  LUT_INIT => X"C33C"
)
port map (
I0 => NN_2,
I1 => COUNTER(1),
I2 => NN_2,
I3 => COUNTER(0),
O => COUNTER_RNO(1));
\COUNTER_RNO[10]_Z187\: SB_LUT4 
generic map(
  LUT_INIT => X"55AA"
)
port map (
I0 => COUNTER(10),
I1 => NN_2,
I2 => NN_2,
I3 => UN2_COUNTER_CRY_9,
O => COUNTER_RNO(10));
SW1_IBUF: SB_IO 
generic map(
  PIN_TYPE => "000001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => SW1_INTERNAL,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => NN_2,
D_IN_1 => N_3,
D_IN_0 => SW1_C);
I_UART_RX_IBUF: SB_IO 
generic map(
  PIN_TYPE => "000001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => I_UART_RX_INTERNAL,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => NN_2,
D_IN_1 => N_4,
D_IN_0 => I_UART_RX_C);
O_UART_TX_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_UART_TX_13,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => O_UART_TX_C,
D_IN_1 => N_5,
D_IN_0 => N_6);
O_SEGMENT1_A_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT1_A_14,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT1CODE_I(6),
D_IN_1 => N_7,
D_IN_0 => N_8);
O_SEGMENT1_B_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT1_B_15,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT1CODE_I(5),
D_IN_1 => N_10,
D_IN_0 => N_11);
O_SEGMENT1_C_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT1_C_16,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT1CODE_I(4),
D_IN_1 => N_13,
D_IN_0 => N_15);
O_SEGMENT1_D_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT1_D_17,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT1CODE_I(3),
D_IN_1 => N_16,
D_IN_0 => N_17);
O_SEGMENT1_E_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT1_E_18,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT1CODE_I(2),
D_IN_1 => N_18,
D_IN_0 => N_19);
O_SEGMENT1_F_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT1_F_19,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT1CODE_I(1),
D_IN_1 => N_20,
D_IN_0 => N_21);
O_SEGMENT1_G_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT1_G_20,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT1CODE_I(0),
D_IN_1 => N_22,
D_IN_0 => N_23);
O_SEGMENT2_A_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT2_A_21,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT2CODE_I(6),
D_IN_1 => N_24,
D_IN_0 => N_25);
O_SEGMENT2_B_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT2_B_22,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT2CODE_I(5),
D_IN_1 => N_26,
D_IN_0 => N_27);
O_SEGMENT2_C_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT2_C_23,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT2CODE_I(4),
D_IN_1 => N_28,
D_IN_0 => N_29);
O_SEGMENT2_D_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT2_D_24,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT2CODE_I(3),
D_IN_1 => N_30,
D_IN_0 => N_31);
O_SEGMENT2_E_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT2_E_25,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT2CODE_I(2),
D_IN_1 => N_32,
D_IN_0 => N_33);
O_SEGMENT2_F_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT2_F_26,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT2CODE_I(1),
D_IN_1 => N_34,
D_IN_0 => N_35);
O_SEGMENT2_G_OBUF: SB_IO 
generic map(
  PIN_TYPE => "011001",
  PULLUP => '0',
  NEG_TRIGGER => '0',
  IO_STANDARD => "SB_LVCMOS"
)
port map (
PACKAGE_PIN => O_SEGMENT2_G_27,
LATCH_INPUT_VALUE => NN_2,
CLOCK_ENABLE => NN_2,
INPUT_CLK => NN_2,
OUTPUT_CLK => NN_2,
OUTPUT_ENABLE => NN_1,
D_OUT_1 => NN_2,
D_OUT_0 => SEGMENT2CODE_I(0),
D_IN_1 => N_36,
D_IN_0 => N_37);
\TX_BINARYCODE[0]_Z205\: SB_DFFE port map (
Q => TX_BINARYCODE(0),
D => RX_BINARYCODE(0),
C => I_CLK_C_G,
E => \PARALLIZING.UN14_COUNTER\);
\TX_BINARYCODE[1]_Z206\: SB_DFFE port map (
Q => TX_BINARYCODE(1),
D => RX_BINARYCODE(1),
C => I_CLK_C_G,
E => \PARALLIZING.UN14_COUNTER\);
\TX_BINARYCODE[2]_Z207\: SB_DFFE port map (
Q => TX_BINARYCODE(2),
D => RX_BINARYCODE(2),
C => I_CLK_C_G,
E => \PARALLIZING.UN14_COUNTER\);
\TX_BINARYCODE[3]_Z208\: SB_DFFE port map (
Q => TX_BINARYCODE(3),
D => RX_BINARYCODE(3),
C => I_CLK_C_G,
E => \PARALLIZING.UN14_COUNTER\);
\TX_BINARYCODE[4]_Z209\: SB_DFFE port map (
Q => TX_BINARYCODE(4),
D => RX_BINARYCODE(4),
C => I_CLK_C_G,
E => \PARALLIZING.UN14_COUNTER\);
\TX_BINARYCODE[5]_Z210\: SB_DFFE port map (
Q => TX_BINARYCODE(5),
D => RX_BINARYCODE(5),
C => I_CLK_C_G,
E => \PARALLIZING.UN14_COUNTER\);
\TX_BINARYCODE[6]_Z211\: SB_DFFE port map (
Q => TX_BINARYCODE(6),
D => RX_BINARYCODE(6),
C => I_CLK_C_G,
E => \PARALLIZING.UN14_COUNTER\);
\TX_BINARYCODE[7]_Z212\: SB_DFFE port map (
Q => TX_BINARYCODE(7),
D => RX_BINARYCODE(7),
C => I_CLK_C_G,
E => \PARALLIZING.UN14_COUNTER\);
\COUNTER[0]_Z213\: SB_DFFSR port map (
Q => COUNTER(0),
D => COUNTER_I(0),
C => I_CLK_C_G,
R => \PARALLIZING.COUNTER9_0\);
\COUNTER[1]_Z214\: SB_DFFSR port map (
Q => COUNTER(1),
D => COUNTER_RNO(1),
C => I_CLK_C_G,
R => \PARALLIZING.COUNTER9_0\);
\COUNTER[2]_Z215\: SB_DFFSR port map (
Q => COUNTER(2),
D => COUNTER_RNO(2),
C => I_CLK_C_G,
R => \PARALLIZING.COUNTER9_0\);
\COUNTER[3]_Z216\: SB_DFFSR port map (
Q => COUNTER(3),
D => COUNTER_RNO(3),
C => I_CLK_C_G,
R => \PARALLIZING.COUNTER9_0\);
\COUNTER[4]_Z217\: SB_DFFSR port map (
Q => COUNTER(4),
D => COUNTER_RNO(4),
C => I_CLK_C_G,
R => \PARALLIZING.COUNTER9_0\);
\COUNTER[5]_Z218\: SB_DFFSR port map (
Q => COUNTER(5),
D => COUNTER_RNO(5),
C => I_CLK_C_G,
R => \PARALLIZING.COUNTER9_0\);
\COUNTER[6]_Z219\: SB_DFFSR port map (
Q => COUNTER(6),
D => COUNTER_RNO(6),
C => I_CLK_C_G,
R => \PARALLIZING.COUNTER9_0\);
\COUNTER[7]_Z220\: SB_DFFSR port map (
Q => COUNTER(7),
D => COUNTER_RNO(7),
C => I_CLK_C_G,
R => \PARALLIZING.COUNTER9_0\);
\COUNTER[8]_Z221\: SB_DFFSR port map (
Q => COUNTER(8),
D => COUNTER_RNO(8),
C => I_CLK_C_G,
R => \PARALLIZING.COUNTER9_0\);
\COUNTER[9]_Z222\: SB_DFFSR port map (
Q => COUNTER(9),
D => COUNTER_RNO(9),
C => I_CLK_C_G,
R => \PARALLIZING.COUNTER9_0\);
\COUNTER[10]_Z223\: SB_DFFSR port map (
Q => COUNTER(10),
D => COUNTER_RNO(10),
C => I_CLK_C_G,
R => \PARALLIZING.COUNTER9_0\);
\SEGMENT1CODE_I[6]_Z224\: SB_DFFR port map (
Q => SEGMENT1CODE_I(6),
D => M26_0,
C => I_CLK_C_G,
R => SW1DEBOUNCED);
\SEGMENT1CODE_I[5]_Z225\: SB_DFFR port map (
Q => SEGMENT1CODE_I(5),
D => N_12,
C => I_CLK_C_G,
R => SW1DEBOUNCED);
\SEGMENT1CODE_I[4]_Z226\: SB_DFFR port map (
Q => SEGMENT1CODE_I(4),
D => N_14,
C => I_CLK_C_G,
R => SW1DEBOUNCED);
\SEGMENT1CODE_I[3]_Z227\: SB_DFFR port map (
Q => SEGMENT1CODE_I(3),
D => N_9,
C => I_CLK_C_G,
R => SW1DEBOUNCED);
\SEGMENT1CODE_I[2]_Z228\: SB_DFFR port map (
Q => SEGMENT1CODE_I(2),
D => N_16_I,
C => I_CLK_C_G,
R => SW1DEBOUNCED);
\SEGMENT1CODE_I[1]_Z229\: SB_DFFR port map (
Q => SEGMENT1CODE_I(1),
D => N_18_I,
C => I_CLK_C_G,
R => SW1DEBOUNCED);
\SEGMENT1CODE_I[0]_Z230\: SB_DFFR port map (
Q => SEGMENT1CODE_I(0),
D => N_20_I,
C => I_CLK_C_G,
R => SW1DEBOUNCED);
\SEGMENT2CODE_I[6]_Z231\: SB_DFFS port map (
Q => SEGMENT2CODE_I(6),
D => M26,
C => I_CLK_C_G,
S => SW1DEBOUNCED);
\SEGMENT2CODE_I[5]_Z232\: SB_DFFS port map (
Q => SEGMENT2CODE_I(5),
D => SEGMENT2CODE_2_I(5),
C => I_CLK_C_G,
S => SW1DEBOUNCED);
\SEGMENT2CODE_I[4]_Z233\: SB_DFFS port map (
Q => SEGMENT2CODE_I(4),
D => SEGMENT2CODE_2_I(4),
C => I_CLK_C_G,
S => SW1DEBOUNCED);
\SEGMENT2CODE_I[3]_Z234\: SB_DFFS port map (
Q => SEGMENT2CODE_I(3),
D => SEGMENT2CODE_2_I(3),
C => I_CLK_C_G,
S => SW1DEBOUNCED);
\SEGMENT2CODE_I[2]_Z235\: SB_DFFS port map (
Q => SEGMENT2CODE_I(2),
D => M14,
C => I_CLK_C_G,
S => SW1DEBOUNCED);
\SEGMENT2CODE_I[1]_Z236\: SB_DFFS port map (
Q => SEGMENT2CODE_I(1),
D => M10,
C => I_CLK_C_G,
S => SW1DEBOUNCED);
\SEGMENT2CODE_I[0]_Z237\: SB_DFFS port map (
Q => SEGMENT2CODE_I(0),
D => M5,
C => I_CLK_C_G,
S => SW1DEBOUNCED);
UN2_COUNTER_CRY_1_C: SB_CARRY port map (
CO => UN2_COUNTER_CRY_1,
I0 => COUNTER(1),
I1 => NN_2,
CI => COUNTER(0));
UN2_COUNTER_CRY_2_C: SB_CARRY port map (
CO => UN2_COUNTER_CRY_2,
I0 => COUNTER(2),
I1 => NN_2,
CI => UN2_COUNTER_CRY_1);
UN2_COUNTER_CRY_3_C: SB_CARRY port map (
CO => UN2_COUNTER_CRY_3,
I0 => COUNTER(3),
I1 => NN_2,
CI => UN2_COUNTER_CRY_2);
UN2_COUNTER_CRY_4_C: SB_CARRY port map (
CO => UN2_COUNTER_CRY_4,
I0 => COUNTER(4),
I1 => NN_2,
CI => UN2_COUNTER_CRY_3);
UN2_COUNTER_CRY_5_C: SB_CARRY port map (
CO => UN2_COUNTER_CRY_5,
I0 => COUNTER(5),
I1 => NN_2,
CI => UN2_COUNTER_CRY_4);
UN2_COUNTER_CRY_6_C: SB_CARRY port map (
CO => UN2_COUNTER_CRY_6,
I0 => COUNTER(6),
I1 => NN_2,
CI => UN2_COUNTER_CRY_5);
UN2_COUNTER_CRY_7_C: SB_CARRY port map (
CO => UN2_COUNTER_CRY_7,
I0 => COUNTER(7),
I1 => NN_2,
CI => UN2_COUNTER_CRY_6);
UN2_COUNTER_CRY_8_C: SB_CARRY port map (
CO => UN2_COUNTER_CRY_8,
I0 => COUNTER(8),
I1 => NN_2,
CI => UN2_COUNTER_CRY_7);
UN2_COUNTER_CRY_9_C: SB_CARRY port map (
CO => UN2_COUNTER_CRY_9,
I0 => COUNTER(9),
I1 => NN_2,
CI => UN2_COUNTER_CRY_8);
DEBOUNCING: DebounceUnit port map (
sw1_c => SW1_C,
i_Clk_c_g => I_CLK_C_G,
sw1Debounced => SW1DEBOUNCED);
UART_RX: receiver port map (
rx_BinaryCode(7 downto 0) => RX_BINARYCODE(7 downto 0),
i_UART_RX_c => I_UART_RX_C,
i_Clk_c_g => I_CLK_C_G);
UART_TX: transmitter port map (
counter(10 downto 0) => COUNTER(10 downto 0),
tx_BinaryCode(7 downto 0) => TX_BINARYCODE(7 downto 0),
rx_BinaryCode(7 downto 0) => RX_BINARYCODE(7 downto 0),
o_UART_TX_c => O_UART_TX_C,
i_Clk_c_g => I_CLK_C_G,
un14_counter => \PARALLIZING.UN14_COUNTER\,
counter9_0 => \PARALLIZING.COUNTER9_0\);
II_GND: GND port map (
Y => NN_2);
II_VCC: VCC port map (
Y => NN_1);
o_UART_TX <= O_UART_TX_13;
o_Segment1_A <= O_SEGMENT1_A_14;
o_Segment1_B <= O_SEGMENT1_B_15;
o_Segment1_C <= O_SEGMENT1_C_16;
o_Segment1_D <= O_SEGMENT1_D_17;
o_Segment1_E <= O_SEGMENT1_E_18;
o_Segment1_F <= O_SEGMENT1_F_19;
o_Segment1_G <= O_SEGMENT1_G_20;
o_Segment2_A <= O_SEGMENT2_A_21;
o_Segment2_B <= O_SEGMENT2_B_22;
o_Segment2_C <= O_SEGMENT2_C_23;
o_Segment2_D <= O_SEGMENT2_D_24;
o_Segment2_E <= O_SEGMENT2_E_25;
o_Segment2_F <= O_SEGMENT2_F_26;
o_Segment2_G <= O_SEGMENT2_G_27;
I_CLK_INTERNAL <= i_Clk;
SW1_INTERNAL <= sw1;
I_UART_RX_INTERNAL <= i_UART_RX;
end beh;

