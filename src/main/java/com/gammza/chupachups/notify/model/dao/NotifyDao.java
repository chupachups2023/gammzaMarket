package com.gammza.chupachups.notify.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.gammza.chupachups.notify.model.vo.Notify;

@Mapper
public interface NotifyDao {

	int insertNotify(Notify notify);

	ArrayList<Notify> selectNotifyList(String userId);

	int updateNotifyStatus(String userId);

	int selectNewNotify(String userId);

}
