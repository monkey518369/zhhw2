-- 用户数据
insert into SF_USER (USER_ID,USER_NAME,USER_PASSWORD,USER_ENABLED,USER_ACCOUNT_NONEXPIRED,USER_ACCOUNT_NONLOCKED,USER_CREDENTIALS_NONEXPIRED) values ('admin','超级管理员','21232f297a57a5a743894a0e4a801fc3',1,1,1,1);
insert into SF_USER (USER_ID,USER_NAME,USER_PASSWORD,USER_ENABLED,USER_ACCOUNT_NONEXPIRED,USER_ACCOUNT_NONLOCKED,USER_CREDENTIALS_NONEXPIRED,USER_CREATOR,USER_MODIFIER) values ('user','系统管理员','21232f297a57a5a743894a0e4a801fc3',1,1,1,1,'admin','admin');

-- 机构数据
insert into SF_ORG (ORG_ID,ORG_NAME,PARENT_ORG_ID,ORG_DESCRIPTION,ORG_TEL,ORG_ADDRESS,ORG_CONTACT,ORG_ENABLED,ORG_PATH,ORG_LEVEL,ORG_TYPE,ORG_PROPERTY,ORG_ORDER,ORG_VERSION,ORG_CREATOR,ORG_CREATED,ORG_MODIFIER,ORG_MODIFIED) values ('1000','一级机构命名示例',null,null,null,null,null,1,'1000','1','1','1',1,0,'admin', current_timestamp(),'admin', current_timestamp());

-- 模块数据
insert into SF_MODULE (MODULE_ID,MODULE_NAME,MODULE_DESCRIPTION,MODULE_ORDER,MODULE_READ_ONLY,MODULE_VERSION,MODULE_CREATOR,MODULE_CREATED,MODULE_MODIFIER,MODULE_MODIFIED) values ('SF_ORG','机构管理',null,0,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MODULE (MODULE_ID,MODULE_NAME,MODULE_DESCRIPTION,MODULE_ORDER,MODULE_READ_ONLY,MODULE_VERSION,MODULE_CREATOR,MODULE_CREATED,MODULE_MODIFIER,MODULE_MODIFIED) values ('SF_USER','用户管理',null,1,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MODULE (MODULE_ID,MODULE_NAME,MODULE_DESCRIPTION,MODULE_ORDER,MODULE_READ_ONLY,MODULE_VERSION,MODULE_CREATOR,MODULE_CREATED,MODULE_MODIFIER,MODULE_MODIFIED) values ('SF_MENU','菜单管理',null,2,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MODULE (MODULE_ID,MODULE_NAME,MODULE_DESCRIPTION,MODULE_ORDER,MODULE_READ_ONLY,MODULE_VERSION,MODULE_CREATOR,MODULE_CREATED,MODULE_MODIFIER,MODULE_MODIFIED) values ('SF_ROLE','角色管理',null,3,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MODULE (MODULE_ID,MODULE_NAME,MODULE_DESCRIPTION,MODULE_ORDER,MODULE_READ_ONLY,MODULE_VERSION,MODULE_CREATOR,MODULE_CREATED,MODULE_MODIFIER,MODULE_MODIFIED) values ('SF_POSITION','岗位管理',null,4,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MODULE (MODULE_ID,MODULE_NAME,MODULE_DESCRIPTION,MODULE_ORDER,MODULE_READ_ONLY,MODULE_VERSION,MODULE_CREATOR,MODULE_CREATED,MODULE_MODIFIER,MODULE_MODIFIED) values ('SF_FUNCTION','功能管理',null,5,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MODULE (MODULE_ID,MODULE_NAME,MODULE_DESCRIPTION,MODULE_ORDER,MODULE_READ_ONLY,MODULE_VERSION,MODULE_CREATOR,MODULE_CREATED,MODULE_MODIFIER,MODULE_MODIFIED) values ('SF_MODULE','模块管理',null,6,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MODULE (MODULE_ID,MODULE_NAME,MODULE_DESCRIPTION,MODULE_ORDER,MODULE_READ_ONLY,MODULE_VERSION,MODULE_CREATOR,MODULE_CREATED,MODULE_MODIFIER,MODULE_MODIFIED) values ('SF_PERMISSION','权限管理',null,200,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MODULE (MODULE_ID,MODULE_NAME,MODULE_DESCRIPTION,MODULE_ORDER,MODULE_READ_ONLY,MODULE_VERSION,MODULE_CREATOR,MODULE_CREATED,MODULE_MODIFIER,MODULE_MODIFIED) values ('SF_LOG','平台日志',null,8,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MODULE (MODULE_ID,MODULE_NAME,MODULE_DESCRIPTION,MODULE_ORDER,MODULE_READ_ONLY,MODULE_VERSION,MODULE_CREATOR,MODULE_CREATED,MODULE_MODIFIER,MODULE_MODIFIED) values ('SF_ITEM','数据字典管理',null,9,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MODULE (MODULE_ID,MODULE_NAME,MODULE_DESCRIPTION,MODULE_ORDER,MODULE_READ_ONLY,MODULE_VERSION,MODULE_CREATOR,MODULE_CREATED,MODULE_MODIFIER,MODULE_MODIFIED) values ('SF_WORKFLOW','工作流管理',null,10,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MODULE (MODULE_ID,MODULE_NAME,MODULE_DESCRIPTION,MODULE_ORDER,MODULE_READ_ONLY,MODULE_VERSION,MODULE_CREATOR,MODULE_CREATED,MODULE_MODIFIER,MODULE_MODIFIED) values ('SF_OTHER','其他',null,11,null,0,'admin', current_timestamp(),'admin', current_timestamp());

-- 功能数据
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('USER_DELETE','SF_USER','用户删除','/sf/user/delete*',null,0,101021,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('USER_EDIT','SF_USER','用户修改','/sf/user/edit*',null,0,101022,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('USER_LIST','SF_USER','用户查询','/sf/user/index*',null,1,101023,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('USER_ENABLE','SF_USER','用户启用','/sf/user/enabled*',null,0,101024,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('USER_CREATE','SF_USER','用户新建','/sf/user/create*',null,0,101020,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('USER_ROLE','SF_USER','用户授权','/sf/user/role*',null,0,101026,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('USER_DISABLE','SF_USER','用户停用','/sf/user/disabled*',null,0,101025,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('INDEX','SF_OTHER','首页','/',null,0,0,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('ORG_CREATE','SF_ORG','机构新建','/sf/org/create*',null,0,101010,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('ORG_DELETE','SF_ORG','机构删除','/sf/org/edit*',null,0,101011,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('ORG_EDIT','SF_ORG','机构修改','/sf/org/delete*',null,0,101012,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('ORG_LIST','SF_ORG','机构查询','/sf/org/index*',null,1,101013,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('ORG_ENABLE','SF_ORG','机构启用','/sf/org/enabled*',null,0,101014,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('ORG_DISABLE','SF_ORG','机构停用','/sf/org/disabled*',null,0,101015,null,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_FUNCTION (FUNCTION_ID,MODULE_ID,FUNCTION_NAME,FUNCTION_URL,FUNCTION_TYPE,FUNCTION_HAS_PERMISSION,FUNCTION_ORDER,FUNCTION_READ_ONLY,FUNCTION_VERSION,FUNCTION_CREATOR,FUNCTION_CREATED,FUNCTION_MODIFIER,FUNCTION_MODIFIED) values ('WFDEF_CREATE','SF_WORKFLOW','上传流程定义文件','/sf/wfdef/created*',null,0,101015,null,0,'admin', current_timestamp(),'admin', current_timestamp());

-- 系统角色数据
insert into SF_ROLE (ROLE_ID,ROLE_NAME,ROLE_DESCRIPTION,ROLE_TYPE,ROLE_ORDER,ROLE_READ_ONLY,ROLE_VERSION,ROLE_CREATOR,ROLE_CREATED,ROLE_MODIFIER,ROLE_MODIFIED) values ('Administrator','管理员',null,null,0,null,5,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_ROLE (ROLE_ID,ROLE_NAME,ROLE_DESCRIPTION,ROLE_TYPE,ROLE_ORDER,ROLE_READ_ONLY,ROLE_VERSION,ROLE_CREATOR,ROLE_CREATED,ROLE_MODIFIER,ROLE_MODIFIED) values ('GphUser','业务管理角色',null,'PERMISSION',1,null,4,'admin', current_timestamp(),'admin', current_timestamp());

-- 角色用户关联数据
insert into SF_ROLE_USER (USER_ID,ROLE_ID) values ('admin','Administrator');
insert into SF_ROLE_USER (USER_ID,ROLE_ID) values ('user','GphUser');

-- 角色功能关联数据
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('INDEX','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('ORG_CREATE','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('ORG_DELETE','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('ORG_DISABLE','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('ORG_EDIT','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('ORG_ENABLE','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('ORG_LIST','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_CREATE','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_DELETE','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_DISABLE','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_EDIT','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_ENABLE','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_LIST','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_ROLE','GphUser');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_ROLE','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('INDEX','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('ORG_CREATE','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('ORG_DELETE','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('ORG_DISABLE','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('ORG_EDIT','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('ORG_ENABLE','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('ORG_LIST','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_CREATE','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_DELETE','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_DISABLE','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_EDIT','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_ENABLE','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('USER_LIST','Administrator');
insert into SF_ROLE_FUNCTION (FUNCTION_ID,ROLE_ID) values ('WFDEF_CREATE','Administrator');

-- 系统属性数据
insert into SF_PROPERTY ( PROPERTY_ID,PROPERTY_TAB_SIZE,PROPERTY_FILE_ROOT,PROPERTY_COPYRIGHT,PROPERTY_APP_TITLE) values (0,12,'/','XX公司','XX系统');

-- 菜单数据
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('CONFIG',null,'系统配置',null,null,0,'config',200,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('SECURITY',null,'系统安全',null,null,0,'security',100,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('PES_CONFIG',null,'业务配置',null,null,0,'pesconfig',250,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('ITEM_LIST','CONFIG','数据字典','sf/item/list',null,0,'item',210,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('PORTLET_LIST','CONFIG','门户','sf/portlet/list',null,0,'portlet',220,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('CONSOLE_VIEW','SECURITY','控制台','sf/console/view',null,0,'log',190,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('ORG_LIST','SECURITY','组织机构','sf/org/index',null,0,'org',110,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('MODULE_LIST','SECURITY','模块','sf/module/list',null,0,'module',160,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('POSITION_LIST','SECURITY','岗位','sf/position/list',null,0,'position',150,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('ROLE_LIST','SECURITY','角色','sf/role/index',null,0,'role',140,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('MENU_LIST','SECURITY','菜单','sf/menu/index',null,0,'menu',130,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('USER_LIST','SECURITY','用户','sf/user/index',null,0,'user',120,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('FUNCTION_LIST','SECURITY','功能','sf/function/index',null,0,'function',170,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('PERMISSION_LIST','SECURITY','权限','sf/permission/list',null,0,'permission',180,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('WORKFLOW',null,'工作流管理',null,null,0,'workflow',400,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_MENU (MENU_ID,PARENT_MENU_ID,MENU_NAME,MENU_URL,MENU_DESCRIPTION,MENU_IFRAME,MENU_ICON,MENU_ORDER,MENU_READ_ONLY,MENU_OPEN_IN_HOME,MENU_VERSION,MENU_CREATOR,MENU_CREATED,MENU_MODIFIER,MENU_MODIFIED) values ('WFDEF_LIST','WORKFLOW','流程模板管理','sf/wfdef/index',null,0,'workflowdef',0,null,0,0,'admin', current_timestamp(),'admin', current_timestamp());

-- 角色菜单关联数据
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','SECURITY');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','ORG_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','USER_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','MENU_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','ROLE_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','POSITION_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','MODULE_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','FUNCTION_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','PERMISSION_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','CONSOLE_VIEW');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','CONFIG');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','ITEM_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','PORTLET_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','WORKFLOW');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('Administrator','WFDEF_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('GphUser','POSITION_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('GphUser','ORG_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('GphUser','USER_LIST');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('GphUser','SECURITY');
insert into SF_ROLE_MENU (ROLE_ID,MENU_ID) values ('GphUser','ROLE_LIST');

-- 岗位数据
insert into SF_POSITION (POSITION_ID,POSITION_NAME,POSITION_DESCRIPTION,POSITION_TYPE,POSITION_ORDER,POSITION_VERSION,POSITION_CREATOR,POSITION_CREATED,POSITION_MODIFIER,POSITION_MODIFIED) values ('1','管理员',null,'2',1,0,'admin', current_timestamp(),'admin', current_timestamp());
insert into SF_POSITION (POSITION_ID,POSITION_NAME,POSITION_DESCRIPTION,POSITION_TYPE,POSITION_ORDER,POSITION_VERSION,POSITION_CREATOR,POSITION_CREATED,POSITION_MODIFIER,POSITION_MODIFIED) values ('102','操作员',null,'0',1,1,'admin', current_timestamp(),'admin', current_timestamp());

-- 岗位级别数据
insert into SF_POSITION_LEVEL (PL_ID,PL_NAME,PL_VALUE) values ('1','一级','1');
insert into SF_POSITION_LEVEL (PL_ID,PL_NAME,PL_VALUE) values ('2','二级','2');
insert into SF_POSITION_LEVEL (PL_ID,PL_NAME,PL_VALUE) values ('3','三级','3');

-- 岗位级别岗位关联数据
insert into SF_POSITION_PL (POSITION_ID,PL_ID) values ('1','1');
insert into SF_POSITION_PL (POSITION_ID,PL_ID) values ('1','2');
insert into SF_POSITION_PL (POSITION_ID,PL_ID) values ('1','3');

-- 岗位角色关联数据
insert into SF_ROLE_POSITION (ROLE_ID,POSITION_ID) values ('Administrator','1');
insert into SF_ROLE_POSITION (ROLE_ID,POSITION_ID) values ('GphUser','102');

-- 更新用户机构、岗位
update SF_USER set ORG_ID = '1000',POSITION_ID='1' where USER_ID = 'admin';
update SF_USER set ORG_ID = '1000',POSITION_ID='102' where USER_ID = 'user';

-- 数据字典数据
insert into SF_ITEM (ITEM_ID,ITEM_NAME,ITEM_DESCRIPTION,ITEM_IS_PERMISSION,ITEM_ORDER,ITEM_READ_ONLY,ITEM_CREATOR,ITEM_CREATED,ITEM_MODIFIER,ITEM_MODIFIED,ITEM_VERSION) values ('ORG_PROPERTY','机构属性',null,1,1,null,'admin', current_timestamp(),'admin', current_timestamp(),0);
insert into SF_ITEM (ITEM_ID,ITEM_NAME,ITEM_DESCRIPTION,ITEM_IS_PERMISSION,ITEM_ORDER,ITEM_READ_ONLY,ITEM_CREATOR,ITEM_CREATED,ITEM_MODIFIER,ITEM_MODIFIED,ITEM_VERSION) values ('ORG_CATEGORY','机构类型',null,1,2,null,'admin', current_timestamp(),'admin', current_timestamp(),0);
insert into SF_ITEM (ITEM_ID,ITEM_NAME,ITEM_DESCRIPTION,ITEM_IS_PERMISSION,ITEM_ORDER,ITEM_READ_ONLY,ITEM_CREATOR,ITEM_CREATED,ITEM_MODIFIER,ITEM_MODIFIED,ITEM_VERSION) values ('POSITION_TYPE','岗位类型',null,0,3,null,'admin', current_timestamp(),'admin', current_timestamp(),0);
insert into SF_ITEM (ITEM_ID,ITEM_NAME,ITEM_DESCRIPTION,ITEM_IS_PERMISSION,ITEM_ORDER,ITEM_READ_ONLY,ITEM_CREATOR,ITEM_CREATED,ITEM_MODIFIER,ITEM_MODIFIED,ITEM_VERSION) values ('USER_GENDER','用户性别',null,0,4,null,'admin', current_timestamp(),'admin', current_timestamp(),0);
insert into SF_ITEM (ITEM_ID,ITEM_NAME,ITEM_DESCRIPTION,ITEM_IS_PERMISSION,ITEM_ORDER,ITEM_READ_ONLY,ITEM_CREATOR,ITEM_CREATED,ITEM_MODIFIER,ITEM_MODIFIED,ITEM_VERSION) values ('COMMON_YESNO','是',null,0,5,null,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_ITEM (ITEM_ID,ITEM_NAME,ITEM_DESCRIPTION,ITEM_IS_PERMISSION,ITEM_ORDER,ITEM_READ_ONLY,ITEM_CREATOR,ITEM_CREATED,ITEM_MODIFIER,ITEM_MODIFIED,ITEM_VERSION) values ('PERMISSION_TYPE','权限类型',null,0,6,null,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_ITEM (ITEM_ID,ITEM_NAME,ITEM_DESCRIPTION,ITEM_IS_PERMISSION,ITEM_ORDER,ITEM_READ_ONLY,ITEM_CREATOR,ITEM_CREATED,ITEM_MODIFIER,ITEM_MODIFIED,ITEM_VERSION) values ('PERMISSION_TYPE_USER','用户权限类型',null,0,7,null,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_ITEM (ITEM_ID,ITEM_NAME,ITEM_DESCRIPTION,ITEM_IS_PERMISSION,ITEM_ORDER,ITEM_READ_ONLY,ITEM_CREATOR,ITEM_CREATED,ITEM_MODIFIER,ITEM_MODIFIED,ITEM_VERSION) values ('PERMISSION_TYPE_ORG','机构权限类型',null,0,8,null,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_ITEM (ITEM_ID,ITEM_NAME,ITEM_DESCRIPTION,ITEM_IS_PERMISSION,ITEM_ORDER,ITEM_READ_ONLY,ITEM_CREATOR,ITEM_CREATED,ITEM_MODIFIER,ITEM_MODIFIED,ITEM_VERSION) values ('ROLE_TYPE','角色类型',null,0,9,null,'admin',current_timestamp(),'admin',current_timestamp(),0);

-- 数据字典子项目数据
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('101','ORG_PROPERTY','自定义属性1','1',0,null,0,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('102','ORG_PROPERTY','自定义属性2','2',0,null,1,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('103','ORG_CATEGORY','自定义类型1','1',0,null,0,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('104','ORG_CATEGORY','自定义类型2','2',0,null,1,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('401','POSITION_TYPE','全局','0',0,null,0,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('402','POSITION_TYPE','指定机构','1',0,null,1,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('403','POSITION_TYPE','指定级别','2',0,null,2,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('201','USER_GENDER','男','M',0,null,0,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('202','USER_GENDER','女','F',0,null,1,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('301','PERMISSION_TYPE','用户权限','PERMISSION_TYPE_USER',1,null,1,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('302','PERMISSION_TYPE','机构权限','PERMISSION_TYPE_ORG',1,null,2,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('303','PERMISSION_TYPE','字典权限','PERMISSION_TYPE_ITEM',0,null,3,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('304','PERMISSION_TYPE','数值权限','PERMISSION_TYPE_CONSTANT',0,null,4,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('311','PERMISSION_TYPE_USER','登录用户','1',0,null,1,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('312','PERMISSION_TYPE_USER','指定用户','2',0,null,2,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('321','PERMISSION_TYPE_ORG','登录用户所属机构','1',0,null,1,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('322','PERMISSION_TYPE_ORG','登录用户所属及其下级机构','2',0,null,2,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('323','PERMISSION_TYPE_ORG','登录用户所属及其上级机构','3',0,null,3,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('324','PERMISSION_TYPE_ORG','指定机构','4',0,null,4,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('331','ROLE_TYPE','普通权限角色','PERMISSION',0,null,0,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('332','ROLE_TYPE','优先权限角色','PRIORITY',0,null,1,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('333','ROLE_TYPE','禁止权限角色','FORBIDDEN',0,null,2,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('901','COMMON_YESNO','是','Y',0,null,0,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_SUB_ITEM (SUB_ITEM_ID,ITEM_ID,SUB_ITEM_NAME,SUB_ITEM_VALUE,SUB_ITEM_CASCADE,SUB_ITEM_DESCRIPTION,SUB_ITEM_ORDER,SUB_ITEM_CREATOR,SUB_ITEM_CREATED,SUB_ITEM_MODIFIER,SUB_ITEM_MODIFIED,SUB_ITEM_VERSION) values ('902','COMMON_YESNO','否','N',0,null,1,'admin',current_timestamp(),'admin',current_timestamp(),0);
insert into SF_PORTLET (PORTLET_ID,PORTLET_TITLE,PORTLET_URL,PORTLET_DESCRIPTION,PORTLET_ORDER,PORTLET_CREATOR,PORTLET_CREATED,PORTLET_MODIFIER,PORTLET_MODIFIED) values ('PROPERTY_PORTLET','平台属性','sf/config/property/portlet','',1,'admin',current_timestamp(),'admin',current_timestamp());
commit;
