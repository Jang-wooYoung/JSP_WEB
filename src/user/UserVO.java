package user;

import java.util.Date;

public class UserVO {
	private String userUid;				//사용자 고유값
	private String userId;				//사용자 아이디
	private String userPassword;		//사용자 패스워드
	private String userName;			//사용자 이름
	private String userNickname;		//사용자 별명
	private String userPhone;			//사용자 연락처 000-0000-0000
	private String userEmail;			//사용자 이메일 sample@sample.com
	private String usertmpField1;		//사용자 임시필드1
	private String usertmpField2;		//사용자 임시필드2
	private String usertmpField3;		//사용자 임시필드3
	private String usertmpField4;		//사용자 임시필드4
	private String usertmpField5;		//사용자 임시필드5
	private int userLevel;				//사용자 레벨 1~9
	private int userState;				//사용자 상태 0:정상 1:삭제 2: 차단
	private Date register_dt;			//사용자 등록일
	private Date modify_dt;				//사용자 수정일
	
	public String getUserUid() {
		return userUid;
	}
	public void setUserUid(String userUid) {
		this.userUid = userUid;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
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
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUsertmpField1() {
		return usertmpField1;
	}
	public void setUsertmpField1(String usertmpField1) {
		this.usertmpField1 = usertmpField1;
	}
	public String getUsertmpField2() {
		return usertmpField2;
	}
	public void setUsertmpField2(String usertmpField2) {
		this.usertmpField2 = usertmpField2;
	}
	public String getUsertmpField3() {
		return usertmpField3;
	}
	public void setUsertmpField3(String usertmpField3) {
		this.usertmpField3 = usertmpField3;
	}
	public String getUsertmpField4() {
		return usertmpField4;
	}
	public void setUsertmpField4(String usertmpField4) {
		this.usertmpField4 = usertmpField4;
	}
	public String getUsertmpField5() {
		return usertmpField5;
	}
	public void setUsertmpField5(String usertmpField5) {
		this.usertmpField5 = usertmpField5;
	}
	public int getUserLevel() {
		return userLevel;
	}	
	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}	
	public int getUserState() {
		return userState;
	}
	public void setUserState(int userState) {
		this.userState = userState;
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
}
