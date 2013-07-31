public class Diamond{
	public static void main(String args[]){
		Diamond diamond = new Diamond();
		diamond.draw(9);
	}

	private void draw(int height){
		StringBuilder sb = new StringBuilder();
		// Set Top
		sb.append(drawEdge(height));
		// Set non-edge line
		for(int i = 1; i < height - 1; i++){
			int j = 0;
			for(j = 0; j < Math.abs((height - 1) / 2 - i); j++){
				sb.append(' ');
			}
			sb.append('*');
			for(int k = 0; k < height - 2 * j - 2; k++){
				sb.append(' ');
			}
			sb.append("*\n");
		}
		// Set bottom
		sb.append(drawEdge(height));
		// Print
		System.out.println(sb.toString());
	}

	private StringBuilder drawEdge(int height){
		StringBuilder sb = new StringBuilder();
		for(int i = 0; i < (height - 1) / 2; i++){
			sb.append(' ');
		}
		sb.append("*\n");
		return sb;
	}

}

