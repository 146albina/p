#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

using namespace std;
using namespace cv;

int main(int argc, char const *argv[])
{
	Mat img = imread("manual.bmp");
	threshold(img, img, 127, 255, THRESH_BINARY);
	cvtColor(img, img, CV_RGBA2GRAY);
	Mat skel(img.size(), CV_8UC1, Scalar(0));
	Mat temp(img.size(), CV_8UC1);
	Mat eroded;

	Mat element = getStructuringElement(MORPH_CROSS, Size(3, 3));

	bool done;		
	do
	{
		erode(img, eroded, element);
		dilate(eroded, temp, element); // temp = open(img)
		subtract(img, temp, temp);
		bitwise_or(skel, temp, skel);
		eroded.copyTo(img);

		done = (countNonZero(img) == 0);
	} while (!done);


	namedWindow("Skeleton");
	imshow("Skeleton", skel);
	imwrite("skeleton.jpg", skel);
	waitKey(0);
	return 0;
}
