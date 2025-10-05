# RuoYi-Vue agent guide

## 模块拓扑
- `ruoyi-admin` 装配 SpringBoot 启动类 `com.ruoyi.RuoYiApplication`，只放 Web 层 (controller + config) 与安全拦截器。
- `ruoyi-system` 承载业务域 (entity/service/mapper)，对应 SQL Mapper 位于 `ruoyi-system/src/main/resources/mapper`。
- `ruoyi-common` 与 `ruoyi-framework` 提供基础设施：`BaseController`、`AjaxResult`、日志注解 `@Log`、权限工具 `@ss.hasPermi`、多数据源注解 `@DataSource`、JWT 过滤链。
- `ruoyi-quartz` 管理调度任务，Quartz API 经 `com.ruoyi.quartz.service` 暴露。
- `ruoyi-generator` 用于代码生成，读取 `generator.yml` 提供的作者、包路径与表前缀配置。
- 前端在 `ruoyi-ui`，基于 Vue 2 + Element-UI，通过 `src/utils/request.js` 统一 Axios 拦截、Token 注入与导出工具。

## 请求与权限
- Controller 继承 `BaseController` 并返回 `AjaxResult` 或 `TableDataInfo`，列表接口需先调用 `startPage()`。
- 所有写操作搭配 `@Log(title, businessType)` 记录审计日志，同时结合 `@PreAuthorize("@ss.hasPermi('module:resource:action')")` 控制权限。
- Service 层需维护数据权限：常见方法 `checkUserDataScope`、`checkDeptDataScope` 在写操作前调用。
- Redis 作为缓存层，使用 `RedisCache`; 配置来自 `application.yml -> spring.redis`。记得在新增配置项时同步刷新缓存 (参考 `SysConfigServiceImpl.resetConfigCache`)。

## 数据与配置
- MySQL 连接放在 `application-druid.yml`，默认数据库 `ry-vue`，新增环境请同步更新 master/slave 段。
- XML Mapper 路径由 `mybatis.mapperLocations=classpath*:mapper/**/*Mapper.xml` 驱动，新增模块时保持相同目录规则。
- Swagger 通过 `swagger.enabled` 控制，前端代理 `/dev-api` -> 后端 `http://localhost:8080`，定义在 `ruoyi-ui/.env.*` 与 `vue.config.js`。
- 静态文件上传路径使用 `ruoyi.profile`，Windows 默认 `D:/ruoyi/uploadPath`; 构建脚本请确保目录存在或改为环境变量。

## 前端约定
- 所有 REST 调用写在 `src/api` 下的模块文件，返回 Promise 并依赖 `request.js` 自动处理状态码 (200/401/500/601)。
- 全局工具 (字典、时间、导出) 已挂载到 Vue 原型；复用现有方法 `this.getDicts()`、`this.handleTree()` 而非重复实现。
- 路由懒加载遵循 `/views/**` 结构，权限由后端菜单返回的路由元数据驱动；自定义菜单字段时请同时更新 `src/store/modules/permission.js`。

## 常用命令
- 后端：`mvn clean install -DskipTests` 构建所有模块；开发时运行 `ruoyi-admin` 的 `RuoYiApplication`，或在 Windows 使用 `bin\run.bat`。
- 前端：在 `ruoyi-ui` 目录执行 `npm install --registry=https://registry.npmmirror.com`，再用 `npm run dev` 启动 80 端口代理。
- 整体打包：先 `bin\package.bat` (Maven)，再 `ruoyi-ui\bin\build.bat` 产出 `/dist` 拷贝到后端静态资源。

## 生产力提示
- 新增功能按「菜单 -> Controller -> Service -> Mapper -> Vue 视图」顺序扩展，保持 URL 前缀与菜单权限编码一致 (例：`system:user:list`)。
- 如果需要 CRUD 脚手架，优先使用代码生成器（访问 /tool/gen，从 UI 表单生成后端与前端代码）。
- 调试登录问题时，先确认 Redis 缓存中的 token (`token:*`)，再看 `ruoyi-framework/security` 中的 JWT 过滤链。
- Quartz 任务调度触发逻辑集中在 `com.ruoyi.quartz.task`; 新增任务类保持 `public void` + `()` / `(String)` 签名供反射调用。
- 日志输出已自定义 `logback.xml`; 请用 `LoggerFactory.getLogger` 并复用现有分类，避免直接 `System.out`。

## 入门检查
- 确认本地 MySQL/Redis 已与配置匹配，页面验证码可通过 `sys.account.captchaEnabled` 参数开关。
- 若 swagger/json 接口 404，检查前端代理是否携带 `/dev-api` 前缀以及后端 `swagger.pathMapping`。
- 运行 `ruoyi-admin` 后访问 `http://localhost:8080/swagger-ui/index.html` 验证所有模块是否加载成功。

欢迎指出缺失的开发约定，以便完善此说明。
