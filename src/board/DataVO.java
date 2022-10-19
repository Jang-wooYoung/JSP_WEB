package board;

import java.util.Date;

public class DataVO {
	private String dataUid = "";		//게시글고유값
	private String boardUid = "";		//게시판고유값
	private String dataTitle = "";		//게시글 제목
	private String dataContent = "";	//게시글 내용
	private int dataState;				//게시글 상태 0:일반 1:삭제 2:차단 3:공지
	private int dataIdx;				//게시글 번호
	private String userId = "";			//게시글 작성자 아이디
	private String userName = "";		//게시글 작성자 이름
	private String userNickname = "";	//게시글 작성자 닉네임
	private Date register_dt;			//게시글 작성일자
	private Date modify_dt;				//게시글 수정일자
	private int viewCount;				//게시글 조회수
	private String tmpField1 = "";		//임시필드1
	private String tmpField2 = "";		//임시필드2
	private String tmpField3 = "";		//임시필드3
	private String tmpField4 = "";		//임시필드4
	private String tmpField5 = "";		//임시필드5
	
	public String getDataUid() {
		return dataUid;
	}
	public void setDataUid(String dataUid) {
		this.dataUid = dataUid;
	}
	public String getBoardUid() {
		return boardUid;
	}
	public void setBoardUid(String boardUid) {
		this.boardUid = boardUid;
	}
	public String getDataTitle() {
		return dataTitle;
	}
	public void setDataTitle(String dataTitle) {
		this.dataTitle = dataTitle;
	}
	public String getDataContent() {
		return dataContent;
	}
	public void setDataContent(String dataContent) {
		this.dataContent = dataContent;
	}
	public int getDataState() {
		return dataState;
	}
	public void setDataState(int dataState) {
		this.dataState = dataState;
	}
	public int getDataIdx() {
		return dataIdx;
	}
	public void setDataIdx(int dataIdx) {
		this.dataIdx = dataIdx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserNickname() {
		return userNickname;
	}
	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}
	public Date getRegister_dt() {
		return register_dt;
	}
	public void setRegister_dt(Date register_dt) {
		this.register_dt = register_dt;
	}
	public Date getModify_dt() {
		return modify_dt;
	}
	public void setModify_dt(Date modify_dt) {
		this.modify_dt = modify_dt;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public String getTmpField1() {
		return tmpField1;
	}
	public void setTmpField1(String tmpField1) {
		this.tmpField1 = tmpField1;
	}
	public String getTmpField2() {
		return tmpField2;
	}
	public void setTmpField2(String tmpField2) {
		this.tmpField2 = tmpField2;
	}
	public String getTmpField3() {
		return tmpField3;
	}
	public void setTmpField3(String tmpField3) {
		this.tmpField3 = tmpField3;
	}
	public String getTmpField4() {
		return tmpField4;
	}
	public void setTmpField4(String tmpField4) {
		this.tmpField4 = tmpField4;
	}
	public String getTmpField5() {
		return tmpField5;
	}
	public void setTmpField5(String tmpField5) {
		this.tmpField5 = tmpField5;
	}
}
