package board;

import java.util.Date;

public class CommentVO {
	private String commentUid;			//댓글고유값
	private String boardUid;			//댓글게시판고유값
	private String dataUid;				//댓글게시글고유값
	private String userId;				//댓글 작성자 아이디
	private String userName;			//댓글 작성자 이름
	private String userNickname;		//댓글 작성자 별명
	private String commentContent;		//댓글 내용
	private int commentIdx;				//댓글 순서
	private int commentState;			//댓글 상태 0:정상 1:삭제
	private Date register_dt;			//댓글 등록일자
	
	public String getCommentUid() {
		return commentUid;
	}
	public void setCommentUid(String commentUid) {
		this.commentUid = commentUid;
	}
	public String getBoardUid() {
		return boardUid;
	}
	public void setBoardUid(String boardUid) {
		this.boardUid = boardUid;
	}
	public String getDataUid() {
		return dataUid;
	}
	public void setDataUid(String dataUid) {
		this.dataUid = dataUid;
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
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public int getCommentIdx() {
		return commentIdx;
	}
	public void setCommentIdx(int commentIdx) {
		this.commentIdx = commentIdx;
	}
	public int getCommentState() {
		return commentState;
	}
	public void setCommentState(int commentState) {
		this.commentState = commentState;
	}
	public Date getRegister_dt() {
		return register_dt;
	}
	public void setRegister_dt(Date register_dt) {
		this.register_dt = register_dt;
	}
}
