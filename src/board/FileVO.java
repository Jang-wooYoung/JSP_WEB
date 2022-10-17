package board;

import java.util.Date;

public class FileVO {
	private String fileUid;			//첨부파일고유값
	private String boardUid;		//게시판고유값
	private String dataUid;			//게시글고유값
	private String fileMask;		//파일서버저장이름
	private String fileName;		//파일원본이름
	private Long fileSize;			//파일사이즈
	private int fileState;			//파일상태 0:일반 1:삭제
	private Date register_dt;		//등록일
	private String tmpField1;		//임시필드1
	private String tmpField2;		//임시필드2
	private String tmpField3;		//임시필드3
	
	
	public String getFileUid() {
		return fileUid;
	}
	public void setFileUid(String fileUid) {
		this.fileUid = fileUid;
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
	public String getFileMask() {
		return fileMask;
	}
	public void setFileMask(String fileMask) {
		this.fileMask = fileMask;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	public int getFileState() {
		return fileState;
	}
	public void setFileState(int fileState) {
		this.fileState = fileState;
	}
	public Date getRegister_dt() {
		return register_dt;
	}
	public void setRegister_dt(Date register_dt) {
		this.register_dt = register_dt;
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
}
