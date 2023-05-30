package com.yfk.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yfk.domain.HRManage.Job;
import com.yfk.mapper.HRManage.JobMapper;
import com.yfk.service.JobService;
import org.springframework.stereotype.Service;

@Service
public class JobServiceImpl extends ServiceImpl<JobMapper, Job> implements JobService {
}
