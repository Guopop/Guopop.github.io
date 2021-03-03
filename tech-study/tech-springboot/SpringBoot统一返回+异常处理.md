# Spring Boot 统一异常处理和统一返回结果 

### 规定统一响应格式

```java
@ApiModel("响应统一封装")
@Getter
@Builder
public class ResultVO<T> {

    @ApiModelProperty("状态码")
    private int code;

    @ApiModelProperty("操作信息")
    private String msg;

    @ApiModelProperty("返回数据")
    private T data;
}
```

### 规定统一状态枚举

```java
@Getter
public enum ResultEnum {
    OPERATE_SUCCESS(HttpStatus.HTTP_OK, "操作成功"),
    PARAMETER_ERROR(HttpStatus.HTTP_BAD_REQUEST, "请求参数错误"),
    SYSTEM_ERROR(HttpStatus.HTTP_INTERNAL_ERROR, "系统异常"),
    ADMIN_LOGOUT_SUCCESS(HttpStatus.HTTP_OK, "管理员退出成功")
    ;

    private final int code;

    private final String msg;

    ResultEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}
```

### 统一异常处理

```java
@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResultVO argNotValidExceptionHandler(MethodArgumentNotValidException e) {
        BindingResult bindingResult = e.getBindingResult();
        List<String> messages = new ArrayList<>();
        if (bindingResult.hasErrors()) {
            List<ObjectError> allErrors = bindingResult.getAllErrors();
            for (ObjectError error : allErrors) {
                FieldError fieldError = (FieldError) error;
                messages.add(fieldError.getDefaultMessage());
            }
        }
        log.error("请求参数错误: {}", messages);
        return ResultUtil.accept(ResultEnum.PARAMETER_ERROR, messages.toString());
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResultVO<?> illegalArgumentExceptionHandler(IllegalArgumentException e) {
        log.error(e.getMessage(), e);
        return ResultUtil.error(e.getMessage());
    }

    @ExceptionHandler(BaseException.class)
    public ResultVO<?> baseExceptionHandler(BaseException e) {
        log.error(e.getMessage(), e);
        return ResultUtil.accept(ResultEnum.SYSTEM_ERROR, e.getMessage());
    }

    @ExceptionHandler(Exception.class)
    public ResultVO<?> exceptionHandler(Exception e) {
        log.error(e.getMessage(), e);
        return ResultUtil.accept(ResultEnum.SYSTEM_ERROR, e.getMessage());
    }
}
```

### 统一结果返回

```java
@RestControllerAdvice(basePackages = "uh.rdsp.configboard.controller")
public class ResponseBodyHandler implements ResponseBodyAdvice {
    @Override
    public boolean supports(MethodParameter methodParameter, Class aClass) {
        return true;
    } 

    @Override
    public Object beforeBodyWrite(Object o, MethodParameter methodParameter, MediaType mediaType, Class aClass, ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse) {
        if (o instanceof ResultVO) {
            return o;
        }
        if (o instanceof String) {
            return o;
        }
        if (Objects.isNull(o)) {
            return ResultUtil.accept(ResultEnum.OPERATE_SUCCESS);
        } else {
            return ResultUtil.success(o);
        }
    }
}
```

