package com.gammza.chupachups.notify.model.service;

import java.util.ArrayList;

import com.gammza.chupachups.notify.model.vo.Notify;

public interface NotifyService {

	int insertNotify(Notify notify);

	ArrayList<Notify> selectNotifyList(String userId);

	int updateNotifyStatus(String userId);

	int selectNewNotify(String userId);

}
