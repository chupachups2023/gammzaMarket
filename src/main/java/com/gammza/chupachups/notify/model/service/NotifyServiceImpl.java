package com.gammza.chupachups.notify.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gammza.chupachups.notify.model.dao.NotifyDao;
import com.gammza.chupachups.notify.model.vo.Notify;

@Service
public class NotifyServiceImpl implements NotifyService {

	@Autowired
	private NotifyDao notifyDao;

	@Override
	public int insertNotify(Notify notify) {
		return notifyDao.insertNotify(notify);
	}

	@Override
	public ArrayList<Notify> selectNotifyList(String userId) {
		return notifyDao.selectNotifyList(userId);
	}

	@Override
	public int updateNotifyStatus(String userId) {
		return notifyDao.updateNotifyStatus(userId);
	}

	@Override
	public int selectNewNotify(String userId) {
		return notifyDao.selectNewNotify(userId);
	}
}
