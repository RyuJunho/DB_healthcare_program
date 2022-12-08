package UI;

import javax.swing.*;

import org.knowm.xchart.*;

import UI.mainUI;
import java.awt.Color;
import java.awt.Font;

public class chartPanel extends JPanel{
	/**
	 * @wbp.parser.entryPoint
	 */
	public chartPanel(){
		init();
	}
	public void init() {
		setBackground(Color.WHITE);
		
		setLayout(null);
		
		JLabel lblNewLabel = new JLabel("회원 수치 차트");
		lblNewLabel.setFont(new Font("맑은 고딕", Font.PLAIN, 12));
		lblNewLabel.setBounds(12, 10, 100, 15);
		add(lblNewLabel);
		//chart
		double[] xData = new double[] {0.0, 1.0, 2.0};
		double[] yData = new double[] {2.0, 1.0, 0.0}; 
		XYChart chart = QuickChart.getChart("Sample Chart", "X", "Y", "y(x)", xData, yData);

		//그래프 패널
		JPanel cPanel = new XChartPanel<XYChart>(chart);
		add(cPanel);
	}

}
