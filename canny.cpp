//#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

 
int main()
{
	// Read an Image
	cv::Mat image = cv::imread("input.jpg");
	cv::Mat image_gray;
	cv::cvtColor(image, image_gray, CV_RGB2GRAY);
	// Apply Canny algorithm
	cv::Mat contours;
	cv::Canny(image_gray,
			contours,
			10,
			80);
	// Create Image Window, named "My Image"
	cv::namedWindow("My Image");
	// Show the Image on window
	cv::imshow("My Image", image);
	// Create Contour window
	cv::namedWindow("Contours Image");
	// Display contour
	cv::imshow("Contours Image", contours);
	// Write contour image into file
	cv::imwrite("output.jpg", contours);
	cv::waitKey(0);
	return 0;
}
