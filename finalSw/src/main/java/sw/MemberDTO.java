package sw;

public class MemberDTO {
	private String id;
	private String name;
	private String whether;
	
	public MemberDTO(String id, String name, String whether) {
		this.id = id;
		this.name = name;
		this.whether = whether;
	}

	public String getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getWhether() {
		return whether;
	}
}
