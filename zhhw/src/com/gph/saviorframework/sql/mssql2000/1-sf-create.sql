/*==============================================================*/
/* Table: SF_FIELD                                            */
/*==============================================================*/
create table SF_FIELD  (
   FIELD_ID             INTEGER                       not null,
   FUNCTION_ID          VARCHAR(50),
   FIELD_CODE           VARCHAR(50),
   FIELD_NAME           VARCHAR(100),
   FIELD_TYPE           VARCHAR(10),
   FIELD_READ_ONLY      SMALLINT,
   FIELD_VERSION        INTEGER                        default 0,
   FIELD_ORDER          INTEGER,
   FIELD_CREATOR        VARCHAR(50),
   FIELD_CREATED        DATETIME,
   FIELD_MODIFIER       VARCHAR(50),
   FIELD_MODIFIED       DATETIME,
   constraint PK_SF_FIELD primary key (FIELD_ID)
);

/*==============================================================*/
/* Index: FK_FUNCTION_FIELD                                     */
/*==============================================================*/
create index FK_FUNCTION_FIELD on SF_FIELD (
   FUNCTION_ID ASC
);

/*==============================================================*/
/* Table: SF_FUNCTION                                         */
/*==============================================================*/
create table SF_FUNCTION  (
   FUNCTION_ID          VARCHAR(50)                    not null,
   MODULE_ID            VARCHAR(50),
   FUNCTION_NAME        VARCHAR(100),
   FUNCTION_URL         VARCHAR(500),
   FUNCTION_TYPE        VARCHAR(50),
   FUNCTION_HAS_PERMISSION SMALLINT                       default 0,
   FUNCTION_ORDER       INTEGER                        default 0,
   FUNCTION_READ_ONLY   SMALLINT,
   FUNCTION_VERSION     INTEGER                        default 0,
   FUNCTION_CREATOR     VARCHAR(50),
   FUNCTION_CREATED     DATETIME,
   FUNCTION_MODIFIER    VARCHAR(50),
   FUNCTION_MODIFIED    DATETIME,
   constraint PK_SF_FUNCTION primary key (FUNCTION_ID)
);
/*==============================================================*/
/* Index: FK_FUNCTION_MODULE                                    */
/*==============================================================*/
create index FK_FUNCTION_MODULE on SF_FUNCTION (
   MODULE_ID ASC
);

/*==============================================================*/
/* Table: SF_ITEM                                             */
/*==============================================================*/
create table SF_ITEM  (
   ITEM_ID              VARCHAR(50)                    not null,
   ITEM_NAME            VARCHAR(100),
   ITEM_DESCRIPTION     VARCHAR(500),
   ITEM_IS_PERMISSION   SMALLINT,
   ITEM_ORDER           INTEGER                        default 0,
   ITEM_READ_ONLY       SMALLINT,
   ITEM_CREATOR         VARCHAR(50),
   ITEM_CREATED         DATETIME,
   ITEM_MODIFIER        VARCHAR(50),
   ITEM_MODIFIED        DATETIME,
   ITEM_VERSION         INTEGER                        default 0,
   constraint PK_SF_ITEM primary key (ITEM_ID)
);

/*==============================================================*/
/* Table: SF_MENU                                             */
/*==============================================================*/
create table SF_MENU  (
   MENU_ID              VARCHAR(50)                    not null,
   PARENT_MENU_ID       VARCHAR(50),
   MENU_NAME            VARCHAR(100),
   MENU_URL             VARCHAR(500),
   MENU_DESCRIPTION     VARCHAR(1000),
   MENU_IFRAME          SMALLINT,
   MENU_ICON            VARCHAR(50),
   MENU_ORDER           INTEGER                        default 0,
   MENU_READ_ONLY       SMALLINT,
   MENU_OPEN_IN_HOME    SMALLINT                       default 0,
   MENU_VERSION         INTEGER                        default 0,
   MENU_CREATOR         VARCHAR(50),
   MENU_CREATED         DATETIME,
   MENU_MODIFIER        VARCHAR(50),
   MENU_MODIFIED        DATETIME,
   constraint PK_SF_MENU primary key (MENU_ID)
);

/*==============================================================*/
/* Index: FK_MENU_PARENT                                        */
/*==============================================================*/
create index FK_MENU_PARENT on SF_MENU (
   PARENT_MENU_ID ASC
);

/*==============================================================*/
/* Table: SF_MODULE                                           */
/*==============================================================*/
create table SF_MODULE  (
   MODULE_ID            VARCHAR(50)                    not null,
   MODULE_NAME          VARCHAR(100),
   MODULE_DESCRIPTION   VARCHAR(500),
   MODULE_ORDER         INTEGER                        default 0,
   MODULE_READ_ONLY     SMALLINT,
   MODULE_VERSION       INTEGER                        default 0,
   MODULE_CREATOR       VARCHAR(50),
   MODULE_CREATED       DATETIME,
   MODULE_MODIFIER      VARCHAR(50),
   MODULE_MODIFIED      DATETIME,
   constraint PK_SF_MODULE primary key (MODULE_ID)
);

/*==============================================================*/
/* Table: SF_ORG                                              */
/*==============================================================*/
create table SF_ORG  (
   ORG_ID               VARCHAR(50)                    not null,
   ORG_NAME             VARCHAR(100),
   PARENT_ORG_ID        VARCHAR(50),
   ORG_DESCRIPTION      VARCHAR(500),
   ORG_TEL              VARCHAR(50),
   ORG_ADDRESS          VARCHAR(500),
   ORG_CONTACT          VARCHAR(50),
   ORG_PATH             VARCHAR(500),
   ORG_LEVEL            VARCHAR(10),
   ORG_ENABLED          SMALLINT,
   ORG_TYPE             VARCHAR(50),
   ORG_PROPERTY         VARCHAR(50),
   ORG_ORDER            INTEGER                        default 0,
   ORG_VERSION          INTEGER                        default 0,
   ORG_CREATOR          VARCHAR(50),
   ORG_CREATED          DATETIME,
   ORG_MODIFIER         VARCHAR(50),
   ORG_MODIFIED         DATETIME,
   constraint PK_SF_ORG primary key (ORG_ID)
);

/*==============================================================*/
/* Table: SF_PERMISSION                                       */
/*==============================================================*/
create table SF_PERMISSION  (
   PERMISSION_ID        VARCHAR(50)                    not null,
   FIELD_ID             INTEGER,
   SUB_ITEM_ID          VARCHAR(50),
   PERMISSION_NAME      VARCHAR(100),
   PERMISSION_TYPE      VARCHAR(50),
   PERMISSION_EXPRESSION VARCHAR(500),
   PERMISSION_USER_TYPE VARCHAR(50),
   PERMISSION_ORG_TYPE  VARCHAR(50),
   PERMISSION_FIELD_VALUE VARCHAR(100),
   PERMISSION_DESCRIPTION VARCHAR(500),
   PERMISSION_ORDER     INTEGER                        default 0,
   PERMISSION_READ_ONLY SMALLINT,
   PERMISSION_VERSION   INTEGER                        default 0,
   PERMISSION_CREATOR   VARCHAR(50),
   PERMISSION_CREATED   DATETIME,
   PERMISSION_MODIFIER  VARCHAR(50),
   PERMISSION_MODIFIED  DATETIME,
   constraint PK_SF_PERMISSION primary key (PERMISSION_ID)
);

/*==============================================================*/
/* Index: FK_ITEM_PERMISSION                                    */
/*==============================================================*/
create index FK_ITEM_PERMISSION on SF_PERMISSION (
   SUB_ITEM_ID ASC
);

/*==============================================================*/
/* Index: FK_PERMISSION_FIELD                                   */
/*==============================================================*/
create index FK_PERMISSION_FIELD on SF_PERMISSION (
   FIELD_ID ASC
);

/*==============================================================*/
/* Table: SF_PERMISSION_ORG                                   */
/*==============================================================*/
create table SF_PERMISSION_ORG  (
   ORG_ID               VARCHAR(50)                    not null,
   PERMISSION_ID        VARCHAR(50)                    not null,
   constraint PK_SF_PERMISSION_ORG primary key (ORG_ID, PERMISSION_ID)
);

/*==============================================================*/
/* Index: FK_PERMISSION_ORG                                     */
/*==============================================================*/
create index FK_PERMISSION_ORG on SF_PERMISSION_ORG (
   ORG_ID ASC
);

/*==============================================================*/
/* Index: FK_PERMISSION_ORG2                                    */
/*==============================================================*/
create index FK_PERMISSION_ORG2 on SF_PERMISSION_ORG (
   PERMISSION_ID ASC
);

/*==============================================================*/
/* Table: SF_PERMISSION_USER                                  */
/*==============================================================*/
create table SF_PERMISSION_USER  (
   PERMISSION_ID        VARCHAR(50)                    not null,
   USER_ID              VARCHAR(50)                    not null,
   constraint PK_SF_PERMISSION_USER primary key (PERMISSION_ID, USER_ID)
);

/*==============================================================*/
/* Index: FK_PERMISSION_USER                                    */
/*==============================================================*/
create index FK_PERMISSION_USER on SF_PERMISSION_USER (
   PERMISSION_ID ASC
);

/*==============================================================*/
/* Index: FK_PERMISSION_USER2                                   */
/*==============================================================*/
create index FK_PERMISSION_USER2 on SF_PERMISSION_USER (
   USER_ID ASC
);

/*==============================================================*/
/* Table: SF_PORTLET                                          */
/*==============================================================*/
create table SF_PORTLET  (
   PORTLET_ID           VARCHAR(50)                    not null,
   PORTLET_TITLE        VARCHAR(100),
   PORTLET_URL          VARCHAR(100),
   PORTLET_DESCRIPTION  VARCHAR(500),
   PORTLET_ORDER        INTEGER,
   PORTLET_CREATOR      VARCHAR(50),
   PORTLET_CREATED      DATETIME,
   PORTLET_MODIFIER     VARCHAR(50),
   PORTLET_MODIFIED     DATETIME,
   PORTLET_VERSION      INTEGER,
   constraint PK_SF_PORTLET primary key (PORTLET_ID)
);

/*==============================================================*/
/* Table: SF_PORTLET_LOCATION                                 */
/*==============================================================*/
create table SF_PORTLET_LOCATION  (
   PORTLET_LOCATION_ID  INTEGER                         not null,
   PORTLET_ID           VARCHAR(50),
   POSITION_ID          VARCHAR(50),
   PORTLET_LOCATION_ROW INTEGER,
   PORTLET_LOCATION_COLUMN INTEGER,
   PORTLET_LOCATION_ORDER INTEGER,
   PORTLET_LOCATION_CREATOR VARCHAR(50),
   PORTLET_LOCATION_CREATED DATETIME,
   PORTLET_LOCATION_MODIFIER VARCHAR(50),
   PORTLET_LOCATION_MODIFIED DATETIME,
   PORTLET_LOCATION_VERSION INTEGER,
   constraint PK_SF_PORTLET_LOCATION primary key (PORTLET_LOCATION_ID)
);
/*==============================================================*/
/* Index: FK_PORTLET_LOCATION_PORTLET                           */
/*==============================================================*/
create index FK_PORTLET_LOCATION_PORTLET on SF_PORTLET_LOCATION (
   PORTLET_ID ASC
);

/*==============================================================*/
/* Index: FK_POSITION_PORTLET_LOCATION                          */
/*==============================================================*/
create index FK_POSITION_PORTLET_LOCATION on SF_PORTLET_LOCATION (
   POSITION_ID ASC
);

/*==============================================================*/
/* Table: SF_POSITION                                         */
/*==============================================================*/
create table SF_POSITION  (
   POSITION_ID          VARCHAR(50)                    not null,
   POSITION_NAME        VARCHAR(100),
   POSITION_DESCRIPTION VARCHAR(500),
   POSITION_TYPE        VARCHAR(50),
   POSITION_ORDER       INTEGER                        default 0,
   POSITION_VERSION     INTEGER                        default 0,
   POSITION_CREATOR     VARCHAR(50),
   POSITION_CREATED     DATETIME,
   POSITION_MODIFIER    VARCHAR(50),
   POSITION_MODIFIED    DATETIME,
   constraint PK_SF_POSITION primary key (POSITION_ID)
);

/*==============================================================*/
/* Table: SF_POSITION_LEVEL                                   */
/*==============================================================*/
create table SF_POSITION_LEVEL  (
   PL_ID                VARCHAR(50)                    not null,
   PL_NAME              VARCHAR(100),
   PL_VALUE             VARCHAR(50),
   constraint PK_SF_POSITION_LEVEL primary key (PL_ID)
);

/*==============================================================*/
/* Table: SF_POSITION_ORG                                     */
/*==============================================================*/
create table SF_POSITION_ORG  (
   ORG_ID               VARCHAR(50)                    not null,
   POSITION_ID          VARCHAR(50)                    not null,
   constraint PK_SF_POSITION_ORG primary key (ORG_ID, POSITION_ID)
);

/*==============================================================*/
/* Index: FK_POSITION_ORG                                       */
/*==============================================================*/
create index FK_POSITION_ORG on SF_POSITION_ORG (
   ORG_ID ASC
);

/*==============================================================*/
/* Index: FK_POSITION_ORG2                                      */
/*==============================================================*/
create index FK_POSITION_ORG2 on SF_POSITION_ORG (
   POSITION_ID ASC
);

/*==============================================================*/
/* Table: SF_POSITION_PL                                      */
/*==============================================================*/
create table SF_POSITION_PL  (
   POSITION_ID          VARCHAR(50)                    not null,
   PL_ID                VARCHAR(50)                    not null,
   constraint PK_SF_POSITION_PL primary key (POSITION_ID, PL_ID)
);

/*==============================================================*/
/* Index: FK_POSITION_PL                                        */
/*==============================================================*/
create index FK_POSITION_PL on SF_POSITION_PL (
   POSITION_ID ASC
);

/*==============================================================*/
/* Index: FK_POSITION_PL2                                       */
/*==============================================================*/
create index FK_POSITION_PL2 on SF_POSITION_PL (
   PL_ID ASC
);

/*==============================================================*/
/* Table: SF_PROPERTY                                         */
/*==============================================================*/
create table SF_PROPERTY  (
   PROPERTY_ID          INTEGER                         not null,
   PROPERTY_VERSION     INTEGER                        default 0,
   PROPERTY_TAB_SIZE    INTEGER,
   PROPERTY_FILE_ROOT   VARCHAR(100),
   PROPERTY_COPYRIGHT   VARCHAR(50),
   PROPERTY_APP_TITLE   VARCHAR(50),
   constraint PK_SF_PROPERTY primary key (PROPERTY_ID)
);

/*==============================================================*/
/* Table: SF_ROLE                                             */
/*==============================================================*/
create table SF_ROLE  (
   ROLE_ID              VARCHAR(50)                    not null,
   ROLE_NAME            VARCHAR(100),
   ROLE_DESCRIPTION     VARCHAR(500),
   ROLE_TYPE            VARCHAR(50),
   ROLE_ORDER           INTEGER                        default 0,
   ROLE_READ_ONLY       SMALLINT,
   ROLE_VERSION         INTEGER                        default 0,
   ROLE_CREATOR         VARCHAR(50),
   ROLE_CREATED         DATETIME,
   ROLE_MODIFIER        VARCHAR(50),
   ROLE_MODIFIED        DATETIME,
   constraint PK_SF_ROLE primary key (ROLE_ID)
);

/*==============================================================*/
/* Table: SF_ROLE_FUNCTION                                    */
/*==============================================================*/
create table SF_ROLE_FUNCTION  (
   ROLE_ID              VARCHAR(50)                    not null,
   FUNCTION_ID          VARCHAR(50)                    not null,
   constraint PK_SF_ROLE_FUNCTION primary key (ROLE_ID, FUNCTION_ID)
);

/*==============================================================*/
/* Index: FK_ROLE_FUNCTION                                      */
/*==============================================================*/
create index FK_ROLE_FUNCTION on SF_ROLE_FUNCTION (
   ROLE_ID ASC
);

/*==============================================================*/
/* Index: FK_ROLE_FUNCTION2                                     */
/*==============================================================*/
create index FK_ROLE_FUNCTION2 on SF_ROLE_FUNCTION (
   FUNCTION_ID ASC
);

/*==============================================================*/
/* Table: SF_ROLE_MENU                                        */
/*==============================================================*/
create table SF_ROLE_MENU  (
   ROLE_ID              VARCHAR(50)                    not null,
   MENU_ID              VARCHAR(50)                    not null,
   constraint PK_SF_ROLE_MENU primary key (ROLE_ID, MENU_ID)
);

/*==============================================================*/
/* Index: FK_ROLE_MENU                                          */
/*==============================================================*/
create index FK_ROLE_MENU on SF_ROLE_MENU (
   ROLE_ID ASC
);

/*==============================================================*/
/* Index: FK_ROLE_MENU2                                         */
/*==============================================================*/
create index FK_ROLE_MENU2 on SF_ROLE_MENU (
   MENU_ID ASC
);

/*==============================================================*/
/* Table: SF_ROLE_PERMISSION                                  */
/*==============================================================*/
create table SF_ROLE_PERMISSION  (
   ROLE_ID              VARCHAR(50)                    not null,
   PERMISSION_ID        VARCHAR(50)                    not null,
   constraint PK_SF_ROLE_PERMISSION primary key (ROLE_ID, PERMISSION_ID)
);

/*==============================================================*/
/* Index: FK_ROLE_PERMISSION                                    */
/*==============================================================*/
create index FK_ROLE_PERMISSION on SF_ROLE_PERMISSION (
   ROLE_ID ASC
);

/*==============================================================*/
/* Index: FK_ROLE_PERMISSION2                                   */
/*==============================================================*/
create index FK_ROLE_PERMISSION2 on SF_ROLE_PERMISSION (
   PERMISSION_ID ASC
);

/*==============================================================*/
/* Table: SF_ROLE_POSITION                                    */
/*==============================================================*/
create table SF_ROLE_POSITION  (
   ROLE_ID              VARCHAR(50)                    not null,
   POSITION_ID          VARCHAR(50)                    not null,
   constraint PK_SF_ROLE_POSITION primary key (ROLE_ID, POSITION_ID)
);

/*==============================================================*/
/* Index: FK_ROLE_POSITION                                      */
/*==============================================================*/
create index FK_ROLE_POSITION on SF_ROLE_POSITION (
   ROLE_ID ASC
);

/*==============================================================*/
/* Index: FK_ROLE_POSITION2                                     */
/*==============================================================*/
create index FK_ROLE_POSITION2 on SF_ROLE_POSITION (
   POSITION_ID ASC
);

/*==============================================================*/
/* Table: SF_ROLE_USER                                        */
/*==============================================================*/
create table SF_ROLE_USER  (
   USER_ID              VARCHAR(50)                    not null,
   ROLE_ID              VARCHAR(50)                    not null,
   constraint PK_SF_ROLE_USER primary key (USER_ID, ROLE_ID)
);

/*==============================================================*/
/* Index: FK_ROLE_USER                                          */
/*==============================================================*/
create index FK_ROLE_USER on SF_ROLE_USER (
   USER_ID ASC
);

/*==============================================================*/
/* Index: FK_ROLE_USER2                                         */
/*==============================================================*/
create index FK_ROLE_USER2 on SF_ROLE_USER (
   ROLE_ID ASC
);

/*==============================================================*/
/* Table: SF_SEQUENCES                                        */
/*==============================================================*/
create table SF_SEQUENCES  (
   SEQUENCE_NAME        VARCHAR(100)                   not null,
   NEXT_VAL             INTEGER,
   constraint PK_SF_SEQUENCES primary key (SEQUENCE_NAME)
);

/*==============================================================*/
/* Table: SF_SUB_ITEM                                         */
/*==============================================================*/
create table SF_SUB_ITEM  (
   SUB_ITEM_ID          VARCHAR(50)                    not null,
   ITEM_ID              VARCHAR(50),
   SUB_ITEM_NAME        VARCHAR(100),
   SUB_ITEM_VALUE       VARCHAR(100),
   SUB_ITEM_CASCADE     SMALLINT,
   SUB_ITEM_DESCRIPTION VARCHAR(500),
   SUB_ITEM_ORDER       INTEGER                        default 0,
   SUB_ITEM_CREATOR     VARCHAR(50),
   SUB_ITEM_CREATED     DATETIME,
   SUB_ITEM_MODIFIER    VARCHAR(50),
   SUB_ITEM_MODIFIED    DATETIME,
   SUB_ITEM_VERSION     INTEGER                        default 0,
   constraint PK_SF_SUB_ITEM primary key (SUB_ITEM_ID)
);

/*==============================================================*/
/* Index: FK_ITEM_SUBITEM                                       */
/*==============================================================*/
create index FK_ITEM_SUBITEM on SF_SUB_ITEM (
   ITEM_ID ASC
);

/*==============================================================*/
/* Table: SF_USER                                             */
/*==============================================================*/
create table SF_USER  (
   USER_ID              VARCHAR(50)                    not null,
   POSITION_ID          VARCHAR(50),
   ORG_ID               VARCHAR(50),
   USER_NAME            VARCHAR(100),
   USER_PASSWORD        VARCHAR(100),
   USER_ID_NO           VARCHAR(50),
   USER_GENDER          VARCHAR(1),
   USER_EMAIL           VARCHAR(100),
   USER_BIRTHDAY        DATETIME,
   USER_ADDRESS         VARCHAR(500),
   USER_POST            VARCHAR(50),
   USER_TEL             VARCHAR(50),
   USER_MOBILE          VARCHAR(50),
   USER_DESCRIPTION     VARCHAR(500),
   USER_ENABLED         SMALLINT,
   USER_LOCKED          SMALLINT,
   USER_ACCOUNT_NONEXPIRED SMALLINT,
   USER_ACCOUNT_NONLOCKED SMALLINT,
   USER_CREDENTIALS_NONEXPIRED SMALLINT,
   USER_ORDER           INTEGER                        default 0,
   USER_VERSION         INTEGER                        default 0,
   USER_CREATOR         VARCHAR(50),
   USER_CREATED         DATETIME,
   USER_MODIFIER        VARCHAR(50),
   USER_MODIFIED        DATETIME,
   constraint PK_SF_USER primary key (USER_ID)
);

/*==============================================================*/
/* Index: FK_USER_ORG                                           */
/*==============================================================*/
create index FK_USER_ORG on SF_USER (
   ORG_ID ASC
);

/*==============================================================*/
/* Index: FK_POSITION_USER                                      */
/*==============================================================*/
create index FK_POSITION_USER on SF_USER (
   POSITION_ID ASC
);

alter table SF_FIELD
   add constraint FUNCTION_FIELD foreign key (FUNCTION_ID)
      references SF_FUNCTION (FUNCTION_ID);

alter table SF_FUNCTION
   add constraint FUNCTION_MODULE foreign key (MODULE_ID)
      references SF_MODULE (MODULE_ID);

alter table SF_MENU
   add constraint MENU_PARENT foreign key (PARENT_MENU_ID)
      references SF_MENU (MENU_ID);

alter table SF_PERMISSION
   add constraint ITEM_PERMISSION foreign key (SUB_ITEM_ID)
      references SF_SUB_ITEM (SUB_ITEM_ID);

alter table SF_PERMISSION
   add constraint PERMISSION_FIELD foreign key (FIELD_ID)
      references SF_FIELD (FIELD_ID);

alter table SF_PERMISSION_ORG
   add constraint PERMISSION_ORG foreign key (ORG_ID)
      references SF_ORG (ORG_ID);

alter table SF_PERMISSION_ORG
   add constraint PERMISSION_ORG2 foreign key (PERMISSION_ID)
      references SF_PERMISSION (PERMISSION_ID);

alter table SF_PERMISSION_USER
   add constraint PERMISSION_USER foreign key (PERMISSION_ID)
      references SF_PERMISSION (PERMISSION_ID);

alter table SF_PERMISSION_USER
   add constraint PERMISSION_USER2 foreign key (USER_ID)
      references SF_USER (USER_ID);

alter table SF_PORTLET_LOCATION
   add constraint PORTLET_LOCATION_POR foreign key (PORTLET_ID)
      references SF_PORTLET (PORTLET_ID);

alter table SF_PORTLET_LOCATION
   add constraint POSITION_PORTLET_LOC foreign key (POSITION_ID)
      references SF_POSITION (POSITION_ID);

alter table SF_POSITION_ORG
   add constraint POSITION_ORG foreign key (ORG_ID)
      references SF_ORG (ORG_ID);

alter table SF_POSITION_ORG
   add constraint POSITION_ORG2 foreign key (POSITION_ID)
      references SF_POSITION (POSITION_ID);

alter table SF_POSITION_PL
   add constraint POSITION_PL foreign key (POSITION_ID)
      references SF_POSITION (POSITION_ID);

alter table SF_POSITION_PL
   add constraint POSITION_PL2 foreign key (PL_ID)
      references SF_POSITION_LEVEL (PL_ID);

alter table SF_ROLE_FUNCTION
   add constraint ROLE_FUNCTION foreign key (ROLE_ID)
      references SF_ROLE (ROLE_ID);

alter table SF_ROLE_FUNCTION
   add constraint ROLE_FUNCTION2 foreign key (FUNCTION_ID)
      references SF_FUNCTION (FUNCTION_ID);

alter table SF_ROLE_MENU
   add constraint ROLE_MENU foreign key (ROLE_ID)
      references SF_ROLE (ROLE_ID);

alter table SF_ROLE_MENU
   add constraint ROLE_MENU2 foreign key (MENU_ID)
      references SF_MENU (MENU_ID);

alter table SF_ROLE_PERMISSION
   add constraint ROLE_PERMISSION foreign key (ROLE_ID)
      references SF_ROLE (ROLE_ID);

alter table SF_ROLE_PERMISSION
   add constraint ROLE_PERMISSION2 foreign key (PERMISSION_ID)
      references SF_PERMISSION (PERMISSION_ID);

alter table SF_ROLE_POSITION
   add constraint ROLE_POSITION foreign key (ROLE_ID)
      references SF_ROLE (ROLE_ID);

alter table SF_ROLE_POSITION
   add constraint ROLE_POSITION2 foreign key (POSITION_ID)
      references SF_POSITION (POSITION_ID);

alter table SF_ROLE_USER
   add constraint ROLE_USER foreign key (USER_ID)
      references SF_USER (USER_ID);

alter table SF_ROLE_USER
   add constraint ROLE_USER2 foreign key (ROLE_ID)
      references SF_ROLE (ROLE_ID);

alter table SF_SUB_ITEM
   add constraint ITEM_SUBITEM foreign key (ITEM_ID)
      references SF_ITEM (ITEM_ID);

alter table SF_USER
   add constraint POSITION_USER foreign key (POSITION_ID)
      references SF_POSITION (POSITION_ID);

alter table SF_USER
   add constraint USER_ORG foreign key (ORG_ID)
      references SF_ORG (ORG_ID);