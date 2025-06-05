/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      databricks101.DM1
 *
 * Date Created : Thursday, June 05, 2025 16:24:29
 * Target DBMS : Databricks
 */

CREATE TABLE default.brkr
(
    BRKR_ID          decimal(10, 0)      NOT NULL,
    OFF_LOC_ID       decimal(10, 0),
    BRKR_LST_NME     string              NOT NULL,
    BRKR_FRST_NME    string              NOT NULL,
    BRKR_MID_INTL    string,
    MNGR_ID          decimal(10, 0),
    YR_FRM_WITH      decimal(4, 0)       NOT NULL,
    CONSTRAINT broker_pk PRIMARY KEY (BRKR_ID) NOT ENFORCED DEFERRABLE 
)
;

CREATE TABLE default.clnt
(
    CLNT_ID              decimal(10, 0)      NOT NULL,
    CLNT_FRST_NME        string              NOT NULL,
    CLNT_LST_NME         string              NOT NULL,
    CLNT_GNDR            string              NOT NULL,
    CLNT_BRTH_YR         decimal(4, 0)       NOT NULL,
    CLNT_MRTL_STS        string,
    CLNT_STREET_ADDR     string              NOT NULL,
    CLNT_ZIP_CD          string              NOT NULL,
    CLNT_CITY            string              NOT NULL,
    CLNT_STATE_PRVNCE    string              NOT NULL,
    CLNT_PHN_NUMBER      string              NOT NULL,
    CLNT_HHLD_INCME      decimal(30, 2),
    CLNT_CNTRY           string,
    BRKR_ID              decimal(10, 0)      NOT NULL,
    CONSTRAINT client_pk PRIMARY KEY (CLNT_ID) NOT ENFORCED DEFERRABLE 
)
;

CREATE TABLE default.clnt_trnsactn
(
    CLNT_TRNSACTN_ID      decimal(10, 0)      NOT NULL,
    CLNT_ID               decimal(10, 0)      NOT NULL,
    INVSTMNT_ID           decimal(10, 0)      NOT NULL,
    ACTN                  string              NOT NULL,
    PRCE                  decimal(12, 2)      NOT NULL,
    NBRUNTS               decimal(10, 0)      NOT NULL,
    TRNSACTN_STS          string              NOT NULL,
    TRNSACTN_SUB_TSMP     date                NOT NULL,
    TRNSACTN_COMP_TSMP    date                NOT NULL,
    DESCR                 string,
    BRKR_ID               decimal(10, 0),
    BRKR_COMMSSN          decimal(30, 2),
    CONSTRAINT client_transaction_pk PRIMARY KEY (CLNT_TRNSACTN_ID) NOT ENFORCED DEFERRABLE 
)
;

CREATE TABLE default.invstmnt
(
    INVSTMNT_ID        decimal(10, 0)      NOT NULL,
    INVSTMNT_TYP_ID    decimal(10, 0),
    INVSTMNT_VNDR      string              NOT NULL,
    INVSTMNT_NME       string,
    INVSTMNT_UNT       string,
    INVSTMNT_DUR       string,
    CONSTRAINT investment_pk PRIMARY KEY (INVSTMNT_ID) NOT ENFORCED DEFERRABLE 
)
;

CREATE TABLE default.invstmnt_typ
(
    INVSTMNT_TYP_ID     decimal(10, 0)      NOT NULL,
    INVSTMNT_TYP_NME    string              NOT NULL,
    CONSTRAINT investment_type_pk PRIMARY KEY (INVSTMNT_TYP_ID) NOT ENFORCED DEFERRABLE 
)
;

CREATE TABLE default.off_loc
(
    OFF_LOC_ID          decimal(10, 0)      NOT NULL,
    OFF_NME             string              NOT NULL,
    OFF_ADDR            string              NOT NULL,
    OFF_CITY            string              NOT NULL,
    OFF_STATE_PRVNCE    string              NOT NULL,
    OFF_ZIP_CD          string              NOT NULL,
    OFF_CNTRY           string,
    CONSTRAINT office_location_pk PRIMARY KEY (OFF_LOC_ID) NOT ENFORCED DEFERRABLE 
)
;

CREATE TABLE default.rgn_dim
(
    REGION_ID           decimal(10, 0)      NOT NULL,
    STATE_CODE          string,
    ZIP                 string,
    DEMOGRAPHIC_CODE    string,
    CITY                string,
    CONSTRAINT pk32 PRIMARY KEY (REGION_ID) NOT ENFORCED DEFERRABLE 
)
;

ALTER TABLE default.brkr ADD CONSTRAINT broker_manager 
    FOREIGN KEY (MNGR_ID)
    REFERENCES default.brkr  NOT ENFORCED DEFERRABLE MATCH FULL ON UPDATE NO ACTION ON DELETE NO ACTION
;

ALTER TABLE default.brkr ADD CONSTRAINT broker_office_location 
    FOREIGN KEY (OFF_LOC_ID)
    REFERENCES default.off_loc  NOT ENFORCED DEFERRABLE MATCH FULL ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE default.clnt ADD CONSTRAINT client_broker 
    FOREIGN KEY (BRKR_ID)
    REFERENCES default.brkr  NOT ENFORCED DEFERRABLE MATCH FULL ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE default.clnt_trnsactn ADD CONSTRAINT client_transaction_broker 
    FOREIGN KEY (BRKR_ID)
    REFERENCES default.brkr  NOT ENFORCED DEFERRABLE MATCH FULL ON UPDATE NO ACTION ON DELETE NO ACTION
;

ALTER TABLE default.clnt_trnsactn ADD CONSTRAINT client_transaction_client 
    FOREIGN KEY (CLNT_ID)
    REFERENCES default.clnt  NOT ENFORCED DEFERRABLE MATCH FULL ON UPDATE NO ACTION ON DELETE NO ACTION
;

ALTER TABLE default.clnt_trnsactn ADD CONSTRAINT client_transaction_investment 
    FOREIGN KEY (INVSTMNT_ID)
    REFERENCES default.invstmnt  NOT ENFORCED DEFERRABLE MATCH FULL ON UPDATE NO ACTION ON DELETE NO ACTION
;


ALTER TABLE default.invstmnt ADD CONSTRAINT investment_type 
    FOREIGN KEY (INVSTMNT_TYP_ID)
    REFERENCES default.invstmnt_typ  NOT ENFORCED DEFERRABLE MATCH FULL ON UPDATE NO ACTION ON DELETE NO ACTION
;


