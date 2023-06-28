package com.gammza.chupachups.common.model.vo;

public class PageInfo {

	private int totalRecord;	
	private int nowPage;	
	private int numPerPage;	
	private int pagePerBlock; 
	
	private int totalPage; 
	private int startPage;	
	private int endPage; 	
	
	public PageInfo() {
		super();
	}
	
	public PageInfo(int totalRecord, int nowPage, int numPerPage, int pagePerBlock, int totalPage, int startPage,
			int endPage) {
		super();

		this.totalRecord = totalRecord;
		this.nowPage = nowPage;
		this.numPerPage = numPerPage;
		this.pagePerBlock = pagePerBlock;
		this.totalPage = totalPage;
		this.startPage = startPage;
		this.endPage = endPage;
	}

	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getNumPerPage() {
		return numPerPage;
	}
	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}
	public int getPagePerBlock() {
		return pagePerBlock;
	}
	public void setPagePerBlock(int pagePerBlock) {
		this.pagePerBlock = pagePerBlock;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}


	@Override
	public String toString() {
		return "PageInfo [totalRecord=" + totalRecord + ", nowPage=" + nowPage + ", numPerPage=" + numPerPage
				+ ", pagePerBlock=" + pagePerBlock + ", totalPage=" + totalPage + ", startPage=" + startPage
				+ ", endPage=" + endPage + "]";
	}

	
}

