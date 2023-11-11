#include <algorithm>
#include <chrono>
#include <iostream>
#include <random>

using namespace std;

const int TESTTIMES = 50;
const int RANDRANGE = 1e8;
const int MAXN = 50;
int fib[MAXN];
int countyes;
int countno;

void initfib() {
    // fib(47)=2,971,215,073会超过int的表示范围
    fib[0] = 0;
    fib[1] = 1;
    for (int i = 2; i < 47; i++) {
        fib[i] = fib[i - 1] + fib[i - 2];
    }
}

int randint() {
    // 使用高精度时间戳作为种子
    auto seed = std::chrono::high_resolution_clock::now().time_since_epoch().count();
    std::mt19937 rng(seed);
    return rng() % RANDRANGE;
}

int gcd(int a, int b) {
    int steps = 0;
    while (b != 0) {
        int r = a % b;
        a = b;
        b = r;
        steps++;
    }
    return steps;
}

void testlame() {
    for (int i = 0; i < TESTTIMES; i++) {
        int steps = 0;
        int a = 0;
        int b = 0;
        do {
            a = randint();
            b = randint();
            // 确保b是较小的那个数
            if (b > a)
                swap(a, b);
            steps = gcd(a, b);
        } while (steps >= 47);
        if (b >= fib[steps]) {
            cout << "计算 " << a << " 和 " << b << " 的最大公约数用了 " << steps << " 步，" << endl;
            cout << b << " >= fib(" << steps << ") = " << fib[steps] << "，符合拉梅定理。" << endl;
            countyes++;
        } else {
            cout << "计算 " << a << " 和 " << b << " 的最大公约数用了 " << steps << " 步，" << endl;
            cout << b << " < fib(" << steps << ") = " << fib[steps] << "，不符合拉梅定理。" << endl;
            countno++;
        }
    }
    cout << "一共有 " << countyes << " 次实验符合拉梅定理，";
    cout << countno << " 次实验不符合拉梅定理。" << endl;
}

int main() {
    initfib();
    testlame();
    return 0;
}
