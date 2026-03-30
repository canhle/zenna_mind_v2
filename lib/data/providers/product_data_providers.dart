import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_clean_template/core/network/dio_client.dart';
import 'package:flutter_clean_template/data/datasources/product_remote_datasource.dart';
import 'package:flutter_clean_template/data/repositories/product_repository_impl.dart';
import 'package:flutter_clean_template/domain/repositories/product_repository.dart';

part 'product_data_providers.g.dart';

@riverpod
ProductRemoteDataSource productRemoteDataSource(Ref ref) =>
    ProductRemoteDataSourceImpl(ref.read(dioClientProvider));

@riverpod
ProductRepository productRepository(Ref ref) =>
    ProductRepositoryImpl(ref.read(productRemoteDataSourceProvider));
