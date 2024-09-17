---

---

# [Codeforces Round 972 (Div. 2)](https://codeforces.com/contest/2005)

### A

#### 题意

给5个字符`(aeiou)`,让构成的回文子序列数量最少

#### 题解

尽可能的让相同的字符串放在一起

如果相同的字符串不放在一起，中间夹杂了几个其他字符，由该字符串开始的回文子串数量会增加很多

```cpp
#include <iostream>

using namespace std;
const string str = "aeiou";
int main() {
    int t;
    cin >> t;
    while (t --) {
        int n;
        cin >> n;
        for (int i = 0; i < str.length(); ++ i) {
            for (int j = 0; j < n / str.length(); ++ j) {
                cout << str[i];
            }
            if (n % str.length() >= i + 1) {
                cout << str[i];
            }
        }
        cout << endl;
    }
    return 0;
}
```



## B

#### 题意

给m个老师的位置，查询当学生位置在哪里的时候，老师可以抓到

#### 题解

对老师位置排序，然后对于每个学生位置进行二分搜索

```c++
#include <iostream>
#include <algorithm>

using namespace std;
const int maxn = 1e5+55;
int a[maxn];

int main() {
    int t;
    cin >> t;
    while (t --) {
        int n, m, q;
        cin >> n >> m >> q;
        for (int i = 0; i < m; ++ i) {
            cin >> a[i];
        }
        sort(a, a+m);
        while (q --) {
            int i, l = 0, r = m-1;
            cin >> i;
            if (i <= a[0]) {
                cout << a[0] - 1 << endl;
                continue;
            }
            if (i >= a[m-1]) {
                cout << n - a[m-1] << endl;
                continue;
            }
            while (l < r) {
                int mid = (l+r) >> 1;
                if (a[mid] >= i) {
                    r = mid;
                } else {
                    l = mid+1;
                }
            }
            cout << (a[r] - a[r-1]) / 2 << endl;
        }
    }
    return 0;
}
```

## C

#### 题意

给n个字符串，需要从中选择出一些拼接起来，找出其中的narek的数量 * 5，减去其他其他字符串(n、a、r、e、k)，就是分数

现在需要最大化这个分数

#### 题解

`dp[i][j]` 表示前i个字符串，以j为结尾最大分数
$$
dp[i+1][k] = dp[i][j] + val(j, str[i])
$$

```c++
#include <string>
#include <iostream>
#include <algorithm>

using namespace std;
const int maxn = 1e3+55;

const string temp = "narek";
const int INF = 0x3f3f3f;
int dp[maxn][5];
bool checkCH(char ch) {
    for (int i = 0; i < temp.length(); ++ i) {
        if (temp[i] == ch) {
            return true;
        }
    }
    return false;
}

std::pair<int, int> val(int j, string& str) {
    int score = 0;
    for (int i = 0; i < str.length(); ++ i) {
        if (!checkCH(str[i])) continue;
        if (str[i] == temp[j]) {
            j ++;
        } else {
            score --;
        }
        if (j == temp.length()) {
            j = 0;
            score += 5;
        }
    }
    return make_pair(j, score);
}

int main() {
    int t;
    string str;
    cin >> t;
    while (t --) {
        int n, m;
        cin >> n >> m;
        for (int i = 0; i <= n; ++ i) {
            for (int j = 0; j < temp.length(); ++ j) {
                dp[i][j] = -INF;
            }
        }
        dp[0][0] = 0;
        for (int i = 1; i <= n; ++ i) {
            cin >> str;
            for (int j = 0; j < temp.length(); ++ j) {
                dp[i][j] = dp[i-1][j];
            }
            for (int j = 0; j < temp.length(); ++ j) {
                if (dp[i-1][j] == -INF) continue;
                std::pair<int, int> res = val(j, str);
                int k = res.first;
                int score = res.second + dp[i-1][j];
                dp[i][k] = max(dp[i][k], score);
            }
        }

        int maxx = 0;
        for (int i = 0; i < temp.length(); ++ i) {
            maxx = max(dp[n][i] - i, maxx);
        }
        cout << maxx << endl;
    }
    return 0;
}
```

