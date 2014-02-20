//#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

 
int main()
{
	// Read an Image
	cv::Mat image = cv::imread("input.jpg");
	// Make it black&white
	cv::Mat image_gray;
	cv::cvtColor(image, image_gray, CV_RGB2GRAY);

	// Compute norm of Sobel
	cv::Mat sobelX, sobelY;
	cv::Sobel(image_gray, sobelX, CV_16S, 1, 0);
	cv::Sobel(image_gray, sobelY, CV_16S, 0, 1);
	cv::Mat sobel;
	// Compute the L1 norm
	sobel = abs(sobelX) + abs(sobelY);
	// Find Sobel max value
	double sobmin, sobmax;
	cv::minMaxLoc(sobel, &sobmin, &sobmax);
	// Convertion to 8-bit image
	// sobelImage = -alpha*sobel + 255
	cv::Mat sobelImage, sobelThresholded;
	sobel.convertTo(sobelImage, CV_8U, -255./sobmax, 255);
	// Apply threshold
	int threshold = 243;
	cv::threshold(sobelImage, sobelThresholded, threshold, 255, cv::THRESH_BINARY_INV);
	// Create Image Window, named "My Image"
	cv::namedWindow("My Image");
	// Show the Image on window
	cv::imshow("My Image", image);
	// Create Sobel window
	cv::namedWindow("Sobel Image");
	// Display sobel image
	cv::imshow("Sobel Image", sobelImage);
	// Create sobel-threshold window
	cv::namedWindow("Sobel Thresholded Image");
	// Display sobel thresholded image
	cv::imshow("Sobel Thresholded Image", sobelThresholded);
	// Write contour image into file
	cv::imwrite("outputSobel.jpg", sobelImage);
	cv::imwrite("outputSobelThresholded.jpg", sobelThresholded);
	cv::waitKey(0);
	return 0;
}
