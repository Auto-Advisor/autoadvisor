#include <iostream>
#include <vector>
#include <algorithm>
#include <math.h>
using namespace std;

int number_of_expand;

class Point{
public:
	int x;
	int y;
	Point(int _x, int _y){
		x = _x;
		y = _y;
	}
	Point(){}
};

class Seg{
public:
	Point first;
	Point second;
	Seg(Point p1, Point p2){
		first = p1;
		second = p2;
	}
	Seg(){}
};

int determinant(Point p1, Point p2, Point p3){
	return p1.x * (p2.y - p3.y) + p1.y * (p3.x - p2.x) + p2.x * p3.y - p3.x * p2.y;
}

double g_distance(Point p1, Point p2){
	return sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
}

bool intersect(Seg s1, Seg s2){
	int det_s1p1 = determinant(s1.first, s2.first, s2.second);
	int det_s1p2 = determinant(s1.second, s2.first, s2.second);
	int det_s2p1 = determinant(s2.first, s1.first, s1.second);
	int det_s2p2 = determinant(s2.second, s1.first, s1.second);
	int prod1 = det_s1p1 * det_s1p2;
	int prod2 = det_s2p1 * det_s2p2;
	return ((prod1 < 0) && (prod2 < 0));
}

class Polygon{
public:
	Polygon(){
		num_point = 0;
	}

	Polygon(vector<Point> ps){
		num_point = ps.size();
		points = ps;
	}

	int NumberOfPoint(){
		return num_point;
	}

	vector<Point> pts(){
		return points;
	}

	bool contain(Point p){
		for (int i = 0; i < num_point; i++){
			if (points[i].x == p.x && points[i].y == p.y){
				return true;
			}
		}
		return false;
	}

	int pointIndex(Point p){
		for (int i = 0; i < num_point; i++){
			if (points[i].x == p.x && points[i].y == p.y){
				return i;
			}
		}
		return -1;
	}

	bool isNeighbor(Point p1, Point p2){
		int index_1 = pointIndex(p1);
		int index_2 = pointIndex(p2);
		return (abs(index_1 - index_2) <= 1);
	}

	int num_point;
	vector<Point> points;
};



class Node{
public:
	Node(Point p, double i){
		state = p;
		g = i;
		head = true;
	}
	Node(Point p, double i, Node* n){
		state = p;
		g = i;
		pred = n;
		head = false;
	}

	void successor(vector<Polygon> polygon_list){
		vector<Point> presuc;
		int numPoints = 0;
		for (unsigned int i = 0; i < polygon_list.size(); i++){
			numPoints += polygon_list[i].NumberOfPoint();
			for (int j = 0; j < polygon_list[i].NumberOfPoint(); j++){
				presuc.insert(presuc.end(), polygon_list[i].pts()[j]);
			}
		}

		Seg s1, s2;
		s1.first = state;

		/**
		 * Loop for all node
		 */
		for (unsigned int i = 0; i < presuc.size(); i++){
			bool intersected = false;
			/**
			 * If it is the same as the source, ignore it.
			 */
			if (state.x == presuc[i].x && state.y == presuc[i].y)
				continue;
			/**
			 * s1.second is the another node to be seen by the source.
			 */
			s1.second = presuc[i];
			for (unsigned int j = 0; j < polygon_list.size(); j++){
				if (polygon_list[j].contain(s1.first) && polygon_list[j].contain(s1.second) && polygon_list[j].isNeighbor(s1.first, s1.second)){
					suc.insert(suc.end(), new Node(s1.second, g + g_distance(s1.first, s2.second), this));
					intersected = true;
					break;
				}
			}
			if (intersected == true)
				continue;
			for (unsigned int j = 0; j < polygon_list.size(); j++){
				for (int k = 0; k < polygon_list[j].NumberOfPoint(); k++){
					s2.first = polygon_list[j].pts()[k];
					s2.second = polygon_list[j].pts()[(k+1)%(polygon_list[j].NumberOfPoint())];
					intersected |= intersect(s1, s2);
					if (intersected)
						break;
				}
				if (intersected)
					break;
			}
			if (!intersected)
				suc.insert(suc.end(), new Node(s1.second, g + g_distance(state, s1.second), this));
		}
		number_of_expand++;
	}

	Point state;
	double f;
	double g;
	vector<Node*> suc;
	Node* pred;
	bool head;
};

vector<Node*> openList;
Node* expTree;

bool myfn(Node* n1, Node* n2){
	return n1->f > n2->f ;
}

vector<Node> report(Node* n){
	vector<Node> result;
	while (!n->head){
		result.insert(result.begin(), *n);
		n = n->pred;
	}
	result.insert(result.begin(), *n);
	return result;
}

vector<Node> a_star(Point p1, Point p2, vector<Polygon> scene){
	vector<Point> goal;
	goal.insert(goal.end(), p2);
	scene.insert(scene.end(), goal);
	static Node head(p1, 0);
	vector<Node> result;

	expTree = &head;
	expTree->successor(scene);
	for (unsigned int i = 0; i < expTree->suc.size(); i++){
		expTree->suc[i]->f = g_distance(expTree->suc[i]->state, p2) + expTree->suc[i]->g;
		openList.insert(openList.end(), expTree->suc[i]);
	}
	cout << "Number of expansion = " << number_of_expand << "; last expand at node (" << expTree->state.x << ", " << expTree->state.y << ")" << endl;

	Node* intermediate = &head;
	while (true){
		if (intermediate->state.x == p2.x && intermediate->state.y == p2.y){
			result = report(intermediate);
			break;
		}
		std::sort(openList.begin(), openList.end(), myfn);
		intermediate = openList.back();
		openList.pop_back();
//		cout << "The Point Chosen: (" << intermediate->state.x << ", " << intermediate->state.y << ")" << endl;
//		cout << "Number of items in Open List: " << openList.size() << " which contain: " << endl;
//		for (int i = 0; i < openList.size(); i++){
//			cout << "(" << openList[i]->state.x << ", " << openList[i]->state.y << "): " << openList[i]->f << " || ";
//		}
//		cout << endl;
		intermediate->successor(scene);
		for (unsigned int i = 0; i < intermediate->suc.size(); i++){
			intermediate->suc[i]->f = g_distance(intermediate->suc[i]->state, p2) + intermediate->suc[i]->g;
//			cout << intermediate->suc[i]->state.x << ", " << intermediate->suc[i]->state.y << " " <<
//					intermediate->suc[i]->f << endl;
			openList.insert(openList.end(), intermediate->suc[i]);
		}
		cout << "Number of expansion = " << number_of_expand << "; last expand at node (" << intermediate->state.x << ", " << intermediate->state.y << ")" << endl;
	}
	return result;
}

int main(){
	vector<Point> pv1;
	pv1.insert(pv1.end(), Point(13, 6));
	pv1.insert(pv1.end(), Point(13, 8));
	pv1.insert(pv1.end(), Point(17, 8));
	pv1.insert(pv1.end(), Point(17, 6));
	Polygon p1(pv1);

	vector<Point> pv2;
	pv2.insert(pv2.end(), Point(2, 3));
	pv2.insert(pv2.end(), Point(2, 6));
	pv2.insert(pv2.end(), Point(5, 3));
	Polygon p2(pv2);

	vector<Point> pv3;
	pv3.insert(pv3.end(), Point(14, 14));
	pv3.insert(pv3.end(), Point(14, 17));
	pv3.insert(pv3.end(), Point(17, 17));
	pv3.insert(pv3.end(), Point(17, 14));
	Polygon p3(pv3);

	vector<Point> pv4;
	pv4.insert(pv4.end(), Point(4, 14));
	pv4.insert(pv4.end(), Point(2, 16));
	pv4.insert(pv4.end(), Point(4, 19));
	pv4.insert(pv4.end(), Point(6, 17));
	Polygon p4(pv4);

	vector<Point> pv5;
	pv5.insert(pv5.end(), Point(8, 8));
	pv5.insert(pv5.end(), Point(6, 10));
	pv5.insert(pv5.end(), Point(6, 12));
	pv5.insert(pv5.end(), Point(8, 12));
	pv5.insert(pv5.end(), Point(10, 9));
	Polygon p5(pv5);

	vector<Point> pv6;
	pv6.insert(pv6.end(), Point(15, 10));
	pv6.insert(pv6.end(), Point(13, 11));
	pv6.insert(pv6.end(), Point(13, 13));
	pv6.insert(pv6.end(), Point(16, 12));
	Polygon p6(pv6);

	vector<Point> pv7;
	pv7.insert(pv7.end(), Point(8, 2));
	pv7.insert(pv7.end(), Point(6, 5));
	pv7.insert(pv7.end(), Point(7, 7));
	pv7.insert(pv7.end(), Point(9, 6));
	pv7.insert(pv7.end(), Point(11, 4));
	pv7.insert(pv7.end(), Point(10, 2));
	Polygon p7(pv7);

	vector<Point> pv8;
	pv8.insert(pv8.end(), Point(10, 13));
	pv8.insert(pv8.end(), Point(8, 15));
	pv8.insert(pv8.end(), Point(10, 17));
	pv8.insert(pv8.end(), Point(12, 17));
	pv8.insert(pv8.end(), Point(12, 13));
	Polygon p8(pv8);

	vector<Point> pv9;
	pv9.insert(pv9.end(), Point(16, 2));
	pv9.insert(pv9.end(), Point(13, 3));
	pv9.insert(pv9.end(), Point(14, 5));
	pv9.insert(pv9.end(), Point(17, 5));
	pv9.insert(pv9.end(), Point(18, 3));
	Polygon p9(pv9);

	vector<Polygon> polygon;
	polygon.insert(polygon.end(), p1);
	polygon.insert(polygon.end(), p2);
	polygon.insert(polygon.end(), p3);
	polygon.insert(polygon.end(), p4);
	polygon.insert(polygon.end(), p5);
	polygon.insert(polygon.end(), p6);
	polygon.insert(polygon.end(), p7);
	polygon.insert(polygon.end(), p8);
	polygon.insert(polygon.end(), p9);

	vector<Node> path = a_star(Point(1, 1), Point(19, 19), polygon);
	cout << "Shortest Path: (" << path[0].state.x << ", " << path[0].state.y << ")";
	for (unsigned int i = 1; i < path.size(); i++){
		cout << " -> (" << path[i].state.x << ", " << path[i].state.y << ")";
	}
	return 0;
}
