package com.atguigu.crud.test;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Student;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.StudentMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
/*
 * 推荐Spring的项目使用Spring的单元测试，可以自动注入我们需要的组件
 * 1、导入SpringTest模块
 * 2、@ContextConfiguration指定Spring配置文件的位置
 * */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    StudentMapper studentMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void TestCrud() {
        //插入三个部门（使用逆向工程自动生成的方法）
//		departmentMapper.insertSelective(new Department( "学生部"));
//		departmentMapper.insertSelective(new Department( "信息部"));
//		departmentMapper.insertSelective(new Department( "记者部"));
//		departmentMapper.insertSelective(new Department( "实创部"));

        studentMapper.insertSelective(new Student(null, "冯阳阳", "M", "yangyang@163.com", 1));
        studentMapper.insertSelective(new Student(null, "王静玲", "F", "jingling@163.com", 2));
    }
}
