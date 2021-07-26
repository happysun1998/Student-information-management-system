package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.bean.Student;
import com.atguigu.crud.service.StudentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 *处理员工CRUD请求
 * */
@Controller
public class StudentController {

    @Autowired
    StudentService studentService;


    @RequestMapping(value = "/stu/{stuId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveStu(Student student){
        System.out.println("将要更新的员工数据：");
        System.out.println(student);
        studentService.updateStu(student);
        return Msg.success();
    }
    /**
     * 单个批量二合一
     * 批量删除：1-2-3
     * 单个删除：1
     */
    @RequestMapping(value = "/stu/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteStu(@PathVariable("ids") String ids){
        //批量删除
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装id的集合
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            studentService.deleteBatch(del_ids);
        }else{
            Integer id = Integer.parseInt(ids);
            studentService.deleteStu(id);
        }
        return Msg.success();
    }

    @RequestMapping(value = "/stu/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getStu(@PathVariable("id") Integer id) {
        Student student = studentService.getStu(id);
        return Msg.success().add("stu",student);
    }

    @RequestMapping(value = "/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam(value = "stuName") String stuName) {
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!stuName.matches(regx)) {
            return Msg.fail().add("va_msg", "用户名必须是2-5位中文或者6-16位英文和数字的组合");
        }
        //数据库用户名重复校验
        boolean b = studentService.checkUser(stuName);
        if (b) {
            return Msg.success();//code=100
        } else {
            return Msg.fail().add("va_msg", "用户名重复");//code=200
        }
    }


    @RequestMapping(value = "/stu", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveStu(@Valid Student student, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名：" + fieldError.getField());
                System.out.println("错误信息：" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            studentService.saveStu(student);
            return Msg.success();
        }
    }

    /*
     * 对于ResponseBody，还需要导入Jackson包
     * */

    @RequestMapping("/students")
    @ResponseBody
    public Msg getEmpWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                              Model model) {
        //这不是一个分页查询；需要引入PageHelper分页插件
        PageHelper.startPage(pn, 5);
        List<Student> students = studentService.getAll();
        //使用PageInfo包装
        //封装了详细的分页信息，包括我们查询出来的数据，传入连续显示的页数5
        PageInfo page = new PageInfo(students, 5);
        return Msg.success().add("PageInfo", page);
    }

    /*
     * 查询员工数据（分页查询）
     * */
//    @RequestMapping("/students")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                          Model model) {
        //这不是一个分页查询；需要引入PageHelper分页插件
        PageHelper.startPage(pn, 5);
        List<Student> students = studentService.getAll();
        //使用PageInfo包装
        //封装了详细的分页信息，包括我们查询出来的数据，传入连续显示的页数5
        PageInfo page = new PageInfo(students, 5);
        model.addAttribute("PageInfo", page);
        return "list";
    }
}
