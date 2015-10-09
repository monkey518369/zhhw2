/*==============================================================*/
/* Table: SF_FIELD                                            */
/*==============================================================*/
create table SF_FIELD  (
   FIELD_ID             INTEGER                       not null comment '字段ID',
   FUNCTION_ID          VARCHAR(50) comment '功能ID',
   FIELD_CODE           VARCHAR(50) comment '字段编码',
   FIELD_NAME           VARCHAR(100) comment '字段名称',
   FIELD_TYPE           VARCHAR(10) comment '字段类型',
   FIELD_READ_ONLY      SMALLINT comment '只读数据',
   FIELD_VERSION        INTEGER                        default 0 comment '字段数据版本',
   FIELD_ORDER          INTEGER comment '字段顺序',
   FIELD_CREATOR        VARCHAR(50) comment '字段创建用户',
   FIELD_CREATED        TIMESTAMP comment '字段创建时间',
   FIELD_MODIFIER       VARCHAR(50) comment '字段修改用户',
   FIELD_MODIFIED       TIMESTAMP comment '字段修改时间',
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
   FUNCTION_ID          VARCHAR(50)                    not null comment '功能ID',
   MODULE_ID            VARCHAR(50) comment '模块ID',
   FUNCTION_NAME        VARCHAR(100) comment '功能名称',
   FUNCTION_URL         VARCHAR(500) comment '功能地址',
   FUNCTION_TYPE        VARCHAR(50) comment '菜单功能|页面功能|...',
   FUNCTION_HAS_PERMISSION SMALLINT                       default 0 comment '可配权限',
   FUNCTION_ORDER       INTEGER                        default 0 comment '功能顺序',
   FUNCTION_READ_ONLY   SMALLINT comment '功能只读数据',
   FUNCTION_VERSION     INTEGER                        default 0 comment '功能数据版本',
   FUNCTION_CREATOR     VARCHAR(50) comment '功能创建者',
   FUNCTION_CREATED     TIMESTAMP comment '功能创建时间',
   FUNCTION_MODIFIER    VARCHAR(50) comment '功能修改者',
   FUNCTION_MODIFIED    TIMESTAMP comment '功能修改时间',
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
   ITEM_ID              VARCHAR(50)                    not null comment '数据主项ID',
   ITEM_NAME            VARCHAR(100) comment '数据主项名称',
   ITEM_DESCRIPTION     VARCHAR(500) comment '数据主项描述',
   ITEM_IS_PERMISSION   SMALLINT comment '是字典权限',
   ITEM_ORDER           INTEGER                        default 0 comment '数据主项顺序',
   ITEM_READ_ONLY       SMALLINT comment '数据主项只读数据',
   ITEM_CREATOR         VARCHAR(50) comment '数据主项创建者',
   ITEM_CREATED         TIMESTAMP comment '数据主项创建时间',
   ITEM_MODIFIER        VARCHAR(50) comment '数据主项修改者',
   ITEM_MODIFIED        TIMESTAMP comment '数据主项修改时间',
   ITEM_VERSION         INTEGER                        default 0 comment '数据主项数据版本',
   constraint PK_SF_ITEM primary key (ITEM_ID)
);

/*==============================================================*/
/* Table: SF_MENU                                             */
/*==============================================================*/
create table SF_MENU  (
   MENU_ID              VARCHAR(50)                    not null comment '菜单ID',
   PARENT_MENU_ID       VARCHAR(50) comment '父菜单ID',
   MENU_NAME            VARCHAR(100) comment '菜单名称',
   MENU_URL             VARCHAR(500) comment '菜单地址',
   MENU_DESCRIPTION     VARCHAR(1000) comment '菜单描述',
   MENU_IFRAME          SMALLINT comment '嵌入页面',
   MENU_ICON            VARCHAR(50) comment '菜单图标',
   MENU_ORDER           INTEGER                        default 0 comment '菜单顺序',
   MENU_READ_ONLY       SMALLINT comment '菜单只读数据',
   MENU_OPEN_IN_HOME    SMALLINT                       default 0 comment '是否主页中打开',
   MENU_VERSION         INTEGER                        default 0 comment '菜单数据版本',
   MENU_CREATOR         VARCHAR(50) comment '菜单创建者',
   MENU_CREATED         TIMESTAMP comment '菜单创建时间',
   MENU_MODIFIER        VARCHAR(50) comment '菜单修改者',
   MENU_MODIFIED        TIMESTAMP comment '菜单修改时间',
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
   MODULE_ID            VARCHAR(50)                    not null comment '模块ID',
   MODULE_NAME          VARCHAR(100) comment '模块名称',
   MODULE_DESCRIPTION   VARCHAR(500) comment '模块描述',
   MODULE_ORDER         INTEGER                        default 0 comment '模块顺序',
   MODULE_READ_ONLY     SMALLINT comment '模块只读数据',
   MODULE_VERSION       INTEGER                        default 0 comment '模块数据版本',
   MODULE_CREATOR       VARCHAR(50) comment '模块创建者',
   MODULE_CREATED       TIMESTAMP comment '模块创建时间',
   MODULE_MODIFIER      VARCHAR(50) comment '模块修改者',
   MODULE_MODIFIED      TIMESTAMP comment '模块修改时间',
   constraint PK_SF_MODULE primary key (MODULE_ID)
);

/*==============================================================*/
/* Table: SF_ORG                                              */
/*==============================================================*/
create table SF_ORG  (
   ORG_ID               VARCHAR(50)                    not null comment '机构ID',
   ORG_NAME             VARCHAR(100) comment '机构名称',
   PARENT_ORG_ID        VARCHAR(50) comment '上级机构ID',
   ORG_DESCRIPTION      VARCHAR(500) comment '机构描述',
   ORG_TEL              VARCHAR(50) comment '机构电话',
   ORG_ADDRESS          VARCHAR(500) comment '机构地址',
   ORG_CONTACT          VARCHAR(50) comment '机构联系人',
   ORG_PATH             VARCHAR(500) comment '机构路径',
   ORG_LEVEL            VARCHAR(10) comment '机构等级',
   ORG_ENABLED          SMALLINT comment '机构启用标志',
   ORG_TYPE             VARCHAR(50) comment '机构类型',
   ORG_PROPERTY         VARCHAR(50) comment '机构属性',
   ORG_ORDER            INTEGER                        default 0 comment '机构顺序',
   ORG_VERSION          INTEGER                        default 0 comment '机构数据版本',
   ORG_CREATOR          VARCHAR(50) comment '机构创建者',
   ORG_CREATED          TIMESTAMP comment '机构创建时间',
   ORG_MODIFIER         VARCHAR(50) comment '机构修改者',
   ORG_MODIFIED         TIMESTAMP comment '机构修改时间',
   constraint PK_SF_ORG primary key (ORG_ID)
);

/*==============================================================*/
/* Table: SF_PERMISSION                                       */
/*==============================================================*/
create table SF_PERMISSION  (
   PERMISSION_ID        VARCHAR(50)                    not null comment '权限ID',
   FIELD_ID             integer comment '字段ID',
   SUB_ITEM_ID          VARCHAR(50) comment '数据子项ID',
   PERMISSION_NAME      VARCHAR(100) comment '权限名称',
   PERMISSION_TYPE      VARCHAR(50) comment '字典权限|用户权限|其他权限',
   PERMISSION_EXPRESSION VARCHAR(500) comment '权限表达式',
   PERMISSION_USER_TYPE VARCHAR(50) comment '用户权限类型',
   PERMISSION_ORG_TYPE  VARCHAR(50) comment '机构权限类型',
   PERMISSION_FIELD_VALUE VARCHAR(100) comment '权限字段数值',
   PERMISSION_DESCRIPTION VARCHAR(500) comment '权限描述',
   PERMISSION_ORDER     INTEGER                        default 0 comment '权限顺序',
   PERMISSION_READ_ONLY SMALLINT comment '权限只读数据',
   PERMISSION_VERSION   INTEGER                        default 0 comment '权限数据版本',
   PERMISSION_CREATOR   VARCHAR(50) comment '权限创建者',
   PERMISSION_CREATED   TIMESTAMP comment '权限创建时间',
   PERMISSION_MODIFIER  VARCHAR(50) comment '权限修改者',
   PERMISSION_MODIFIED  TIMESTAMP comment '权限修改时间',
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
   ORG_ID               VARCHAR(50)                    not null comment '机构ID',
   PERMISSION_ID        VARCHAR(50)                    not null comment '权限ID',
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
   PERMISSION_ID        VARCHAR(50)                    not null comment '权限ID',
   USER_ID              VARCHAR(50)                    not null comment '用户ID',
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
   PORTLET_ID           VARCHAR(50)                    not null comment '门户应用ID',
   PORTLET_TITLE        VARCHAR(100) comment '门户应用标题',
   PORTLET_URL          VARCHAR(100) comment '门户应用地址',
   PORTLET_DESCRIPTION  VARCHAR(500) comment '门户应用描述',
   PORTLET_ORDER        INTEGER comment '门户应用顺序',
   PORTLET_CREATOR      VARCHAR(50) comment '门户应用创建用户',
   PORTLET_CREATED      TIMESTAMP comment '门户应用创建时间',
   PORTLET_MODIFIER     VARCHAR(50) comment '门户应用修改用户',
   PORTLET_MODIFIED     TIMESTAMP comment '门户应用修改时间',
   PORTLET_VERSION      INTEGER comment '门户应用数据版本',
   constraint PK_SF_PORTLET primary key (PORTLET_ID)
);

/*==============================================================*/
/* Table: SF_PORTLET_LOCATION                                 */
/*==============================================================*/
create table SF_PORTLET_LOCATION  (
   PORTLET_LOCATION_ID  INTEGER                         not null comment '门户应用位置ID',
   PORTLET_ID           VARCHAR(50) comment '门户应用ID',
   POSITION_ID          VARCHAR(50) comment '岗位ID',
   PORTLET_LOCATION_ROW INTEGER comment '门户应用位置行数',
   PORTLET_LOCATION_COLUMN INTEGER comment '门户应用位置列数',
   PORTLET_LOCATION_ORDER INTEGER comment '门户应用位置顺序',
   PORTLET_LOCATION_CREATOR VARCHAR(50) comment '门户应用位置创建用户',
   PORTLET_LOCATION_CREATED TIMESTAMP comment '门户应用位置创建时间',
   PORTLET_LOCATION_MODIFIER VARCHAR(50) comment '门户应用位置修改用户',
   PORTLET_LOCATION_MODIFIED TIMESTAMP comment '门户应用位置修改时间',
   PORTLET_LOCATION_VERSION INTEGER comment '门户应用位置修改时间',
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
   POSITION_ID          VARCHAR(50)                    not null comment '岗位ID',
   POSITION_NAME        VARCHAR(100) comment '岗位名称',
   POSITION_DESCRIPTION VARCHAR(500) comment '岗位描述',
   POSITION_TYPE        VARCHAR(50) comment '岗位类型',
   POSITION_ORDER       INTEGER                        default 0 comment '岗位顺序',
   POSITION_VERSION     INTEGER                        default 0 comment '岗位数据版本',
   POSITION_CREATOR     VARCHAR(50) comment '岗位创建者',
   POSITION_CREATED     TIMESTAMP comment '岗位创建时间',
   POSITION_MODIFIER    VARCHAR(50) comment '岗位修改者',
   POSITION_MODIFIED    TIMESTAMP comment '岗位修改时间',
   constraint PK_SF_POSITION primary key (POSITION_ID)
);

/*==============================================================*/
/* Table: SF_POSITION_LEVEL                                   */
/*==============================================================*/
create table SF_POSITION_LEVEL  (
   PL_ID                VARCHAR(50)                    not null comment '岗位级别ID',
   PL_NAME              VARCHAR(100) comment '岗位级别名称',
   PL_VALUE             VARCHAR(50) comment '岗位级别数值',
   constraint PK_SF_POSITION_LEVEL primary key (PL_ID)
);

/*==============================================================*/
/* Table: SF_POSITION_ORG                                     */
/*==============================================================*/
create table SF_POSITION_ORG  (
   ORG_ID               VARCHAR(50)                    not null comment '机构ID',
   POSITION_ID          VARCHAR(50)                    not null comment '岗位ID',
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
   POSITION_ID          VARCHAR(50)                    not null comment '岗位ID',
   PL_ID                VARCHAR(50)                    not null comment '岗位级别ID',
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
   PROPERTY_ID          INTEGER                         not null comment '属性ID',
   PROPERTY_VERSION     INTEGER                        default 0 comment '属性数据版本',
   PROPERTY_TAB_SIZE    INTEGER comment '标签数量',
   PROPERTY_FILE_ROOT   VARCHAR(100) comment '文件根路径',
   PROPERTY_COPYRIGHT   VARCHAR(50) comment '版权信息',
   PROPERTY_APP_TITLE   VARCHAR(50) comment '系统名称',
   constraint PK_SF_PROPERTY primary key (PROPERTY_ID)
);

/*==============================================================*/
/* Table: SF_ROLE                                             */
/*==============================================================*/
create table SF_ROLE  (
   ROLE_ID              VARCHAR(50)                    not null comment '角色ID',
   ROLE_NAME            VARCHAR(100) comment '角色名称',
   ROLE_DESCRIPTION     VARCHAR(500) comment '角色描述',
   ROLE_TYPE            VARCHAR(50) comment '角色类型',
   ROLE_ORDER           INTEGER                        default 0 comment '角色顺序',
   ROLE_READ_ONLY       SMALLINT comment '角色只读数据',
   ROLE_VERSION         INTEGER                        default 0 comment '角色数据版本',
   ROLE_CREATOR         VARCHAR(50) comment '角色创建者',
   ROLE_CREATED         TIMESTAMP comment '角色创建时间',
   ROLE_MODIFIER        VARCHAR(50) comment '角色修改者',
   ROLE_MODIFIED        TIMESTAMP comment '角色修改时间',
   constraint PK_SF_ROLE primary key (ROLE_ID)
);

/*==============================================================*/
/* Table: SF_ROLE_FUNCTION                                    */
/*==============================================================*/
create table SF_ROLE_FUNCTION  (
   ROLE_ID              VARCHAR(50)                    not null comment '角色ID',
   FUNCTION_ID          VARCHAR(50)                    not null comment '功能ID',
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
   ROLE_ID              VARCHAR(50)                    not null comment '角色ID',
   MENU_ID              VARCHAR(50)                    not null comment '菜单ID',
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
   ROLE_ID              VARCHAR(50)                    not null comment '角色ID',
   PERMISSION_ID        VARCHAR(50)                    not null comment '权限ID',
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
   ROLE_ID              VARCHAR(50)                    not null comment '角色ID',
   POSITION_ID          VARCHAR(50)                    not null comment '岗位ID',
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
   USER_ID              VARCHAR(50)                    not null comment '用户ID',
   ROLE_ID              VARCHAR(50)                    not null comment '角色ID',
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
   SEQUENCE_NAME        VARCHAR(100)                   not null comment '主键名称',
   NEXT_VAL             integer comment '下个数值',
   constraint PK_SF_SEQUENCES primary key (SEQUENCE_NAME)
);

/*==============================================================*/
/* Table: SF_SUB_ITEM                                         */
/*==============================================================*/
create table SF_SUB_ITEM  (
   SUB_ITEM_ID          VARCHAR(50)                    not null comment '数据子项ID',
   ITEM_ID              VARCHAR(50) comment '数据主项ID',
   SUB_ITEM_NAME        VARCHAR(100) comment '数据子项名称',
   SUB_ITEM_VALUE       VARCHAR(100) comment '数据子项值',
   SUB_ITEM_CASCADE     SMALLINT comment '级联字典',
   SUB_ITEM_DESCRIPTION VARCHAR(500) comment '数据子项描述',
   SUB_ITEM_ORDER       INTEGER                        default 0 comment '数据子项顺序',
   SUB_ITEM_CREATOR     VARCHAR(50) comment '数据子项创建者',
   SUB_ITEM_CREATED     TIMESTAMP comment '数据子项创建时间',
   SUB_ITEM_MODIFIER    VARCHAR(50) comment '数据子项修改者',
   SUB_ITEM_MODIFIED    TIMESTAMP comment '数据子项修改时间',
   SUB_ITEM_VERSION     INTEGER                        default 0 comment '数据子项数据版本',
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
   USER_ID              VARCHAR(50)                    not null comment '用户ID',
   POSITION_ID          VARCHAR(50) comment '岗位ID',
   ORG_ID               VARCHAR(50) comment '机构ID',
   USER_NAME            VARCHAR(100) comment '用户姓名',
   USER_PASSWORD        VARCHAR(100) comment '用户密码',
   USER_ID_NO           VARCHAR(50) comment '用户身份证号',
   USER_GENDER          VARCHAR(1) comment '用户性别',
   USER_EMAIL           VARCHAR(100) comment '用户邮件地址',
   USER_BIRTHDAY        DATE comment '用户生日',
   USER_ADDRESS         VARCHAR(500) comment '用户地址',
   USER_POST            VARCHAR(50) comment '用户邮编',
   USER_TEL             VARCHAR(50) comment '用户电话',
   USER_MOBILE          VARCHAR(50) comment '用户手机',
   USER_DESCRIPTION     VARCHAR(500) comment '用户描述',
   USER_ENABLED         SMALLINT comment '帐户已启用',
   USER_LOCKED          SMALLINT comment '锁定标志',
   USER_ACCOUNT_NONEXPIRED SMALLINT comment '帐户未过期',
   USER_ACCOUNT_NONLOCKED SMALLINT comment '帐户未锁定',
   USER_CREDENTIALS_NONEXPIRED SMALLINT comment '凭证未过期',
   USER_ORDER           INTEGER                        default 0 comment '用户顺序',
   USER_VERSION         INTEGER                        default 0 comment '用户数据版本',
   USER_CREATOR         VARCHAR(50) comment '用户创建者',
   USER_CREATED         TIMESTAMP comment '用户创建时间',
   USER_MODIFIER        VARCHAR(50) comment '用户修改者',
   USER_MODIFIED        TIMESTAMP comment '用户修改时间',
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

commit;