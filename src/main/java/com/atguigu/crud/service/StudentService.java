package com.atguigu.crud.service;


import com.atguigu.crud.bean.Student;
import com.atguigu.crud.bean.StudentExample;
import com.atguigu.crud.dao.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {

    @Autowired
    StudentMapper studentMapper;

    /*
    * 查询所有学生信息
    * */
    public List<Student> getAll() {
        return studentMapper.selectByExampleWithDept(null);
    }

    /*
    * 保存所有学生信息
    * */
    public void saveStu(Student student) {
        studentMapper.insertSelective(student);
    }

    /*
    * 校验用户名是否可用
    * */
    public boolean checkUser(String stuName) {
        StudentExample example = new StudentExample();
        StudentExample.Criteria criteria = example.createCriteria();
        criteria.andStuNameEqualTo(stuName);
        long count = studentMapper.countByExample(example);
        return count==0;
    }

    public Student getStu(Integer id) {
        Student student = studentMapper.selectByPrimaryKey(id);
        return student;
    }

    public void updateStu(Student student) {
        studentMapper.updateByPrimaryKeySelective(student);
    }

    public void deleteStu(Integer id) {
        studentMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> del_ids) {
        StudentExample example = new StudentExample();
        StudentExample.Criteria criteria = example.createCriteria();
        criteria.andStuIdIn(del_ids);
        studentMapper.deleteByExample(example);
    }
}
